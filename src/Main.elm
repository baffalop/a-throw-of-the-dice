module Main exposing (..)

import Angle exposing (Angle)
import Axis3d exposing (Axis3d)
import Basics.Extra exposing (..)
import Browser
import Browser.Events
import Camera3d exposing (Camera3d)
import Color
import Css
import Direction2d
import Direction3d
import Duration exposing (Duration)
import Ease
import Frame2d
import HSLuv exposing (HSLuv)
import Html exposing (Html)
import Html.Styled as Styled
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events as StyledEvents
import Html.Styled.Lazy
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode
import Length
import LineSegment2d exposing (LineSegment2d)
import LineSegment3d exposing (LineSegment3d)
import LineSegment3d.Projection
import List.Extra
import Path.LowLevel as SvgPath exposing (DrawTo(..), Mode(..), MoveTo(..))
import Pixels
import Point2d exposing (Point2d)
import Point3d exposing (Point3d)
import Point3d.Projection
import PortFunnel.WebSocket as WS
import PortFunnels as Funnels
import Quantity
import Rectangle2d exposing (Rectangle2d)
import Rectangle3d exposing (Rectangle3d)
import SketchPlane3d exposing (SketchPlane3d)
import Svg.Styled as SvgStyled
import Svg.Styled.Attributes as SvgAttr
import Svg.Styled.Events
import Vector2d exposing (Vector2d)
import Vector3d exposing (Vector3d)
import Viewpoint3d exposing (Viewpoint3d)
import ZipList exposing (ZipList)


main =
    Browser.document
        { init = init
        , view =
            \model ->
                { title = "One Toss of the Mouse"
                , body = view model
                }
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    Flags
        { world : World
        , centrePoint : SourcePoint
        , focus : WorldPoint
        , transition : Maybe Transition
        , azimuth : Angle
        , elevation : Angle
        , drawnRect : Maybe DrawnRect
        , funnelState : Funnels.State
        }


type alias Flags a =
    { a
        | devicePixelRatio : Float
        , screenDimensions : ( Int, Int )
        , webSocketUrl : String
    }


type alias World =
    { origin : Int
    , layers : ZipList Layer
    }


type alias Layer =
    { plane : SourcePlane
    , rects : List Rect
    , hue : Float
    }


type alias DrawnRect =
    { originPoint : SourcePoint
    , rect : PlaneRect
    }


type alias Transition =
    { from : WorldPoint
    , to : WorldPoint
    , at : Float
    }


type Msg
    = MouseDown Float Float
    | MouseUp
    | MouseMove Float Float
    | Wheel Float Float
    | ClickedTo Int WorldPoint
    | AnimationTick Float
    | WindowResize Int Int
    | ArrowKeyPressed Direction
    | FunnelMsg Encode.Value
    | NoOp


type Direction
    = Left
    | Right


init : Flags {} -> ( Model, Cmd Msg )
init { devicePixelRatio, screenDimensions, webSocketUrl } =
    let
        ( screenWidth, screenHeight ) =
            screenDimensions

        sourcePlane =
            SketchPlane3d.xy

        centrePoint =
            Point2d.centimeters
                (toFloat screenWidth * (13.2 / 1000))
                (toFloat screenHeight * (10 / 800))
    in
    { world =
        { origin = 0
        , layers =
            ZipList.singleton
                { plane = sourcePlane
                , rects = []
                , hue = theme.initialLayerHue
                }
        }
    , centrePoint = centrePoint
    , focus = centrePoint |> Point3d.on sourcePlane
    , transition = Nothing
    , azimuth = Angle.degrees 90
    , elevation = Angle.degrees 0
    , drawnRect = Nothing
    , screenDimensions = screenDimensions
    , devicePixelRatio = devicePixelRatio
    , webSocketUrl = webSocketUrl
    , funnelState = Funnels.initialState
    }
        |> withCmd (wsCmd <| WS.makeOpenWithKey wsKey webSocketUrl)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Browser.Events.onKeyDown <| arrowKeyDecoder ArrowKeyPressed
        , Browser.Events.onResize WindowResize
        , case model.transition of
            Nothing ->
                Sub.none

            Just _ ->
                Browser.Events.onAnimationFrameDelta AnimationTick
        , Funnels.subscriptions FunnelMsg model
        ]


arrowKeyDecoder : (Direction -> msg) -> Decoder msg
arrowKeyDecoder msg =
    Decode.field "key" Decode.string
        |> Decode.andThen
            (\keycode ->
                case keycode of
                    "ArrowRight" ->
                        Decode.succeed <| msg Right

                    "ArrowLeft" ->
                        Decode.succeed <| msg Left

                    _ ->
                        Decode.fail "nah"
            )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case msg of
        NoOp ->
            noOp

        MouseDown x y ->
            let
                currentLayer =
                    ZipList.current model.world.layers
            in
            { model
                | drawnRect =
                    ( x, y )
                        |> raycastTo currentLayer.plane (makeCameraGeometry model) model.devicePixelRatio
                        |> Maybe.map
                            (\point ->
                                { originPoint = point
                                , rect = rectFrom point point
                                }
                            )
            }
                |> withNoCmd

        MouseMove x y ->
            case model.drawnRect of
                Nothing ->
                    noOp

                Just rect ->
                    let
                        currentLayer =
                            getCurrentLayer model.world
                    in
                    { model
                        | drawnRect =
                            ( x, y )
                                |> raycastTo currentLayer.plane (makeCameraGeometry model) model.devicePixelRatio
                                |> Maybe.map (\endPoint -> { rect | rect = rectFrom rect.originPoint endPoint })
                    }
                        |> withNoCmd

        MouseUp ->
            case model.drawnRect of
                Nothing ->
                    noOp

                Just { rect } ->
                    { model
                        | drawnRect = Nothing
                        , world =
                            mapCurrentLayer
                                (\({ rects, plane } as current) ->
                                    { current | rects = (rect |> Rectangle3d.on plane) :: rects }
                                )
                                model.world
                    }
                        |> withCmd (sendApiMsg <| ApiInsert { span = rectToApi rect, layer = relativeIndex model.world })

        Wheel deltaX deltaY ->
            let
                add delta =
                    Angle.inDegrees >> (+) (delta * wheelCoefficient) >> Angle.degrees
            in
            { model
                | azimuth = model.azimuth |> add deltaX
                , elevation = model.elevation |> add deltaY
            }
                |> withNoCmd

        ClickedTo layerIndex newFocus ->
            let
                withLayerSet =
                    { model | world = model.world |> goToIndex layerIndex }
            in
            withNoCmd <|
                if newFocus |> Point3d.equalWithin (Length.centimeters 0.2) model.focus then
                    withLayerSet

                else
                    withLayerSet |> transitionFocusTo newFocus

        AnimationTick delta ->
            withNoCmd <|
                case model.transition of
                    Nothing ->
                        model

                    Just ({ from, to } as transition) ->
                        let
                            at =
                                transition.at + (delta / Duration.inMilliseconds transitionDuration)
                        in
                        if at >= 1 then
                            { model
                                | focus = to
                                , transition = Nothing
                            }

                        else
                            { model
                                | focus = Point3d.interpolateFrom from to <| Ease.inOutCubic at
                                , transition = Just { transition | at = at }
                            }

        WindowResize width height ->
            { model | screenDimensions = ( width, height ) }
                |> withNoCmd

        ArrowKeyPressed key ->
            let
                planesAreFacingRight =
                    getCurrentLayer model.world
                        |> .plane
                        |> isFacingRightOf (makeViewpoint model)

                direction =
                    if planesAreFacingRight then
                        reverse key

                    else
                        key

                newFocus =
                    model.focus |> Point3d.translateBy (zVectorFromDirection direction)
            in
            { model
                | drawnRect = Nothing
                , world = moveLayer direction model.world
            }
                |> transitionFocusTo newFocus
                |> withNoCmd

        FunnelMsg value ->
            case Funnels.processValue funnelDict value model.funnelState model of
                Err err ->
                    let
                        _ =
                            Debug.log "Funnel error" err
                    in
                    noOp

                Ok result ->
                    result


updateFromWebsocket : WS.Response -> Funnels.State -> Model -> ( Model, Cmd Msg )
updateFromWebsocket response funnelState model_ =
    let
        model =
            { model_ | funnelState = funnelState }

        noOp =
            ( model, Cmd.none )

        justLog msg x =
            let
                _ =
                    Debug.log msg x
            in
            noOp
    in
    case response of
        WS.MessageReceivedResponse { message } ->
            let
                _ =
                    Debug.log "WS message received" message
            in
            case Decode.decodeString downDecoder message of
                Err err ->
                    justLog "Decode error" err

                Ok (ApiError err) ->
                    justLog "API error" err

                Ok (ApiUpdate newWorld) ->
                    { model | world = updateWorld newWorld model.world }
                        |> withNoCmd

        WS.CmdResponse msg ->
            model |> withCmd (wsCmd msg)

        WS.ListResponse _ ->
            justLog "WS list" ()

        WS.ErrorResponse err ->
            justLog "WS error" err

        WS.ConnectedResponse _ ->
            justLog "WS connected" ()

        _ ->
            noOp


transitionFocusTo : WorldPoint -> Model -> Model
transitionFocusTo focus model =
    { model
        | transition =
            Just
                { from = model.focus
                , to = focus
                , at = 0
                }
    }



-- VIEW


type SvgBehaviour
    = Focusable Int Css.Color
    | Inert


view : Model -> List (Html Msg)
view model =
    List.map Styled.toUnstyled <|
        [ Styled.div
            [ css
                [ Css.position Css.absolute
                , Css.maxWidth Css.minContent
                , Css.top <| Css.px 40
                , Css.right <| Css.px 40
                , Css.padding <| Css.px 8
                , Css.backgroundColor theme.accent
                , Css.color theme.dark
                , Css.fontFamilies [ "Fira Code", "monospace" ]
                , Css.lineHeight <| Css.em 1.6
                , Css.letterSpacing <| Css.em -0.02
                ]
            ]
          <|
            nowrapTexts
                [ "Draw rectangles."
                , "Scroll to spin."
                , "Left/right arrows to switch layers."
                , "Click a rectangle to go there."
                ]
        , Html.Styled.Lazy.lazy viewSvg model
        ]


viewSvg : Model -> Styled.Html Msg
viewSvg model =
    let
        ( screenWidth, screenHeight ) =
            subtractScreenMargins model.screenDimensions

        camera =
            makeCameraGeometry model

        currentLayer =
            getCurrentLayer model.world

        currentIndex =
            ZipList.currentIndex model.world.layers

        orderByDepth =
            if currentLayer.plane |> isFacingAwayFrom (Camera3d.viewpoint camera.camera) then
                List.reverse

            else
                identity

        focusRect =
            ( Length.centimeters (toFloat screenWidth * 22 / 1000), Length.centimeters (toFloat screenHeight * 17 / 800) )
                |> Rectangle2d.centeredOn (Frame2d.atPoint model.centrePoint)
                |> Rectangle3d.on currentLayer.plane

        mouseEvents =
            case model.drawnRect of
                Nothing ->
                    [ StyledEvents.on "mousedown" <| coordinateDecoder "offset" MouseDown
                    ]

                Just _ ->
                    [ StyledEvents.on "mousemove" <| coordinateDecoder "offset" MouseMove
                    , StyledEvents.onMouseUp MouseUp
                    ]
    in
    model.world.layers
        |> ZipList.toList
        |> List.indexedMap
            (\index ->
                viewLayer camera
                    (if index == currentIndex then
                        model.drawnRect

                     else
                        Nothing
                    )
                    index
            )
        |> orderByDepth
        |> (::) (viewFocusRect camera currentLayer.hue focusRect)
        |> SvgStyled.svg
            (mouseEvents
                ++ [ SvgAttr.width <| String.fromInt screenWidth ++ "px"
                   , SvgAttr.height <| String.fromInt screenHeight ++ "px"
                   , StyledEvents.preventDefaultOn "wheel" <| coordinateDecoder "delta" (\x y -> ( Wheel x y, True ))
                   ]
            )


viewLayer : CameraGeometry -> Maybe DrawnRect -> Int -> Layer -> SvgStyled.Svg Msg
viewLayer camera drawnRect index { plane, rects, hue } =
    let
        maybeAppendDrawnRect =
            drawnRect
                |> Maybe.andThen (.rect >> Rectangle3d.on plane >> viewRect camera Inert)
                |> Maybe.map (::)
                |> Maybe.withDefault identity
    in
    rects
        |> List.filterMap (viewRect camera (Focusable index <| theme.lighter hue))
        |> maybeAppendDrawnRect
        |> SvgStyled.g
            [ SvgAttr.css
                [ Css.fill <| theme.light hue
                , Css.margin <| Css.px 0
                ]
            ]


viewRect : CameraGeometry -> SvgBehaviour -> Rect -> Maybe (SvgStyled.Svg Msg)
viewRect cameraGeometry behaviour rect =
    let
        viewPlane =
            cameraGeometry.camera
                |> Camera3d.viewpoint
                |> Viewpoint3d.viewPlane
    in
    if Rectangle3d.vertices rect |> List.all (inFrontOf viewPlane) then
        let
            cornerRadius =
                Length.centimeters 0.2

            path =
                rect
                    |> Rectangle3d.edges
                    |> List.map (projectEdge cameraGeometry)
                    |> roundCorners cornerRadius

            attributes =
                case behaviour of
                    Focusable layerIndex highlightColour ->
                        [ Svg.Styled.Events.onClick <| ClickedTo layerIndex <| Rectangle3d.centerPoint rect
                        , Svg.Styled.Events.stopPropagationOn "mousedown" <| Decode.succeed ( NoOp, True )
                        , SvgAttr.css
                            [ Css.cursor Css.pointer
                            , Css.hover
                                [ Css.fill highlightColour
                                ]
                            ]
                        ]

                    Inert ->
                        []
        in
        Just <|
            SvgStyled.path
                (SvgAttr.d (SvgPath.toString path) :: attributes)
                []

    else
        Nothing


viewFocusRect : CameraGeometry -> Float -> Rect -> SvgStyled.Svg msg
viewFocusRect cameraGeometry hue rect =
    let
        viewPlane =
            cameraGeometry.camera
                |> Camera3d.viewpoint
                |> Viewpoint3d.viewPlane
                -- we will use this plane to find intersections
                -- but if you try to project a point that lies on the viewplane itself you get NaNs
                -- so offset forward little so intersections lie in front of the camera
                |> SketchPlane3d.offsetBy (Length.centimeter |> Quantity.multiplyBy -1)

        coords =
            Rectangle3d.edges rect
                |> List.concatMap (verticesClippedTo viewPlane)
                |> List.map (projectPoint cameraGeometry >> svgCoord)

        ( startCoords, remainingCoords ) =
            List.Extra.uncons coords
                |> Maybe.withDefault ( ( 0, 0 ), [] )

        path =
            { moveto = MoveTo Absolute startCoords
            , drawtos = [ LineTo Absolute (remainingCoords ++ [ startCoords ]) ]
            }
    in
    SvgStyled.path
        [ SvgAttr.d <| SvgPath.toString [ path ]
        , SvgAttr.stroke <| hsluvToSvgColor hue 0.7 0.5
        , SvgAttr.strokeWidth "2"
        , SvgAttr.strokeDasharray "8 6"
        , SvgAttr.fillOpacity "0"
        ]
        []


nowrapTexts : List String -> List (Styled.Html msg)
nowrapTexts =
    List.map
        (Styled.text
            >> List.singleton
            >> Styled.span [ css [ Css.whiteSpace Css.noWrap ] ]
        )
        >> List.intersperse (Styled.text " ")



-- SVG


roundCorners : Length.Length -> List ScreenLine -> List SvgPath.SubPath
roundCorners radius edges =
    let
        ( endCoords, path ) =
            concatMapCarry (roundedCornerSegments radius) edges
    in
    endCoords
        |> Maybe.map
            (\coords ->
                { moveto = MoveTo Absolute coords
                , drawtos = path
                }
                    |> List.singleton
            )
        |> Maybe.withDefault []


roundedCornerSegments : Length.Length -> ScreenLine -> ( ( Float, Float ), List DrawTo )
roundedCornerSegments radius edge =
    let
        diameter =
            radius |> Quantity.multiplyBy 2

        ( a, b ) =
            LineSegment2d.endpoints edge
    in
    if LineSegment2d.length edge |> Quantity.lessThan diameter then
        let
            endCoord =
                svgCoord <| LineSegment2d.midpoint edge
        in
        [ QuadraticBezierCurveTo Absolute [ ( svgCoord a, endCoord ) ]
        ]
            |> Tuple.pair endCoord

    else
        let
            radiusVector =
                LineSegment2d.direction edge
                    |> Maybe.map (Vector2d.withLength radius)
                    |> Maybe.withDefault Vector2d.zero

            anchorA =
                a |> Point2d.translateBy radiusVector

            anchorB =
                b |> Point2d.translateBy (Vector2d.reverse radiusVector)

            endCoord =
                svgCoord anchorB
        in
        [ QuadraticBezierCurveTo Absolute [ ( svgCoord a, svgCoord anchorA ) ]
        , LineTo Absolute [ endCoord ]
        ]
            |> Tuple.pair endCoord


verticesClippedTo : ViewPlane -> WorldLine -> List WorldPoint
verticesClippedTo viewPlane edge =
    let
        ( start, end ) =
            LineSegment3d.endpoints edge
    in
    case edge |> LineSegment3d.intersectionWithPlane (SketchPlane3d.toPlane viewPlane) of
        Nothing ->
            if start |> inFrontOf viewPlane then
                [ start, end ]

            else
                []

        Just intersection ->
            if start |> inFrontOf viewPlane then
                [ start, intersection ]

            else
                [ intersection, end ]


svgCoord : ScreenPoint -> ( Float, Float )
svgCoord =
    Point2d.toRecord Length.inCssPixels
        >> (\{ x, y } -> ( x, y ))



-- LAYERS


getCurrentLayer : World -> Layer
getCurrentLayer { layers } =
    ZipList.current layers


mapCurrentLayer : (Layer -> Layer) -> World -> World
mapCurrentLayer f ({ layers } as world) =
    { world | layers = ZipList.replace (f <| ZipList.current layers) layers }


goToIndex : Int -> World -> World
goToIndex index ({ layers } as world) =
    { world
        | layers =
            ZipList.goToIndex index layers
                |> Maybe.withDefault layers
    }


moveLayer : Direction -> World -> World
moveLayer direction world =
    let
        move =
            case direction of
                Left ->
                    ZipList.maybeJumpBackward 1

                Right ->
                    ZipList.maybeJumpForward 1
    in
    case move world.layers of
        Just l ->
            { world | layers = l }

        Nothing ->
            grow direction world


grow : Direction -> World -> World
grow direction world =
    let
        { insert, absoluteIndex, newOrigin } =
            case direction of
                Left ->
                    { insert = ziplistInsertBefore
                    , absoluteIndex = -world.origin - 1
                    , newOrigin = world.origin + 1
                    }

                Right ->
                    { insert = ZipList.insert
                    , absoluteIndex = ZipList.length world.layers - world.origin + 1
                    , newOrigin = world.origin
                    }

        newLayer =
            { plane = sourcePlaneFromIndex absoluteIndex
            , rects = []
            , hue = hueFromIndex absoluteIndex
            }
    in
    { origin = newOrigin
    , layers = insert newLayer world.layers
    }


updateWorld : ApiWorld -> World -> World
updateWorld api world =
    { origin = api.origin
    , layers =
        apiToLayers api
            |> ZipList.fromList
            |> Maybe.andThen (ZipList.goToIndex <| api.origin + relativeIndex world)
            |> Maybe.withDefault world.layers
    }


relativeIndex : World -> Int
relativeIndex { layers, origin } =
    ZipList.currentIndex layers - origin


sourcePlaneFromIndex : Int -> SourcePlane
sourcePlaneFromIndex index =
    let
        originPlane =
            SketchPlane3d.xy

        zVector =
            planeSpacing
                |> Quantity.multiplyBy (toFloat index)
                |> Vector3d.xyz zeroMeters zeroMeters
    in
    originPlane |> SketchPlane3d.translateBy zVector


hueFromIndex : Int -> Float
hueFromIndex index =
    theme.initialLayerHue + (index * layerHueSpacing) |> modBy 256 |> toFloat



-- API


type alias ApiWorld =
    { origin : Int
    , layers : ApiLayers
    }


type alias ApiLayers =
    List (List ApiRect)


type alias ApiRect =
    { x1 : Float
    , y1 : Float
    , x2 : Float
    , y2 : Float
    }


type UpMsg
    = ApiInsert { layer : Int, span : ApiRect }


type DownMsg
    = ApiUpdate ApiWorld
    | ApiError String


apiToLayers : ApiWorld -> List Layer
apiToLayers { origin, layers } =
    List.indexedMap
        (\index apiLayer ->
            let
                absoluteIndex =
                    index - origin

                plane =
                    sourcePlaneFromIndex absoluteIndex
            in
            { plane = plane
            , rects = List.map (apiToRect plane) apiLayer
            , hue = hueFromIndex absoluteIndex
            }
        )
        layers


apiToRect : SourcePlane -> ApiRect -> Rect
apiToRect plane { x1, y1, x2, y2 } =
    Rectangle2d.with
        { x1 = Length.millimeters x1
        , y1 = Length.millimeters y1
        , x2 = Length.millimeters x2
        , y2 = Length.millimeters y2
        }
        |> Rectangle3d.on plane


worldDecoder : Decoder ApiWorld
worldDecoder =
    Decode.map2
        ApiWorld
        (Decode.field "origin" Decode.int)
        (Decode.field "layers" <| Decode.list <| Decode.list rectDecoder)


rectDecoder : Decoder ApiRect
rectDecoder =
    Decode.map4
        ApiRect
        (Decode.field "x1" Decode.float)
        (Decode.field "y1" Decode.float)
        (Decode.field "x2" Decode.float)
        (Decode.field "y2" Decode.float)


rectToApi : PlaneRect -> ApiRect
rectToApi rect =
    let
        toTuple =
            Point2d.toTuple Length.inMillimeters

        ( ( x1, y1 ), ( x2, y2 ) ) =
            case Rectangle2d.vertices rect of
                [ v1, _, v2, _ ] ->
                    ( toTuple v1, toTuple v2 )

                _ ->
                    ( ( 0, 0 ), ( 0, 0 ) )
    in
    { x1 = x1
    , y1 = y1
    , x2 = x2
    , y2 = y2
    }


encodeRect : ApiRect -> Encode.Value
encodeRect { x1, y1, x2, y2 } =
    Encode.object
        [ ( "x1", Encode.float x1 )
        , ( "y1", Encode.float y1 )
        , ( "x2", Encode.float x2 )
        , ( "y2", Encode.float y2 )
        ]


encodeUp : UpMsg -> Encode.Value
encodeUp msg =
    case msg of
        ApiInsert { layer, span } ->
            Encode.object
                [ ( "msg", Encode.string "insert" )
                , ( "layer", Encode.int layer )
                , ( "span", encodeRect span )
                ]


downDecoder : Decoder DownMsg
downDecoder =
    Decode.field "msg" Decode.string
        |> Decode.andThen
            (\msg ->
                case msg of
                    "establish" ->
                        Decode.map ApiUpdate <| Decode.field "world" worldDecoder

                    "update" ->
                        Decode.map ApiUpdate <| Decode.field "world" worldDecoder

                    "error" ->
                        Decode.map ApiError <| Decode.field "errorMsg" Decode.string

                    _ ->
                        Decode.fail <| "invalid msg type " ++ msg
            )


sendApiMsg : UpMsg -> Cmd Msg
sendApiMsg =
    encodeUp >> Encode.encode 0 >> WS.makeSend wsKey >> wsCmd



-- GEOMETRY


type alias SourcePlane =
    SketchPlane3d Length.Meters WorldCoordinates { defines : SourceCoordinates }


type alias ViewPlane =
    SketchPlane3d Length.Meters WorldCoordinates { defines : ScreenCoordinates }


type SourceCoordinates
    = SourceCoordinates Never


type ScreenCoordinates
    = ScreenCoordinates Never


type WorldCoordinates
    = WorldCoordinates Never


type alias SourcePoint =
    Point2d Length.Meters SourceCoordinates


type alias WorldPoint =
    Point3d Length.Meters WorldCoordinates


type alias WorldLine =
    LineSegment3d Length.Meters WorldCoordinates


type alias ScreenLine =
    LineSegment2d Length.Meters ScreenCoordinates


type alias ScreenPoint =
    Point2d Length.Meters ScreenCoordinates


type alias Camera =
    Camera3d Length.Meters WorldCoordinates


type alias Viewpoint =
    Viewpoint3d Length.Meters WorldCoordinates


type alias CameraGeometry =
    { camera : Camera
    , screenRect : Rectangle2d Length.Meters ScreenCoordinates
    }


type alias Rect =
    Rectangle3d Length.Meters WorldCoordinates


type alias PlaneRect =
    Rectangle2d Length.Meters SourceCoordinates


rectFrom : SourcePoint -> SourcePoint -> PlaneRect
rectFrom originPoint endPoint =
    let
        halfHeight =
            Vector2d.centimeters 0 0.5

        length =
            Vector2d.from originPoint endPoint
                |> Vector2d.xComponent
                |> flip Vector2d.xy (Length.meters 0)

        topLeft =
            originPoint
                |> Point2d.translateBy (Vector2d.reverse halfHeight)

        bottomRight =
            originPoint
                |> Point2d.translateBy (halfHeight |> Vector2d.plus length)
    in
    Rectangle2d.from topLeft bottomRight


raycastTo : SourcePlane -> CameraGeometry -> Float -> ( Float, Float ) -> Maybe SourcePoint
raycastTo sourcePlane { camera, screenRect } pixelRatio ( x, y ) =
    Point2d.pixels x y
        |> Point2d.at_ (resolution pixelRatio)
        |> Camera3d.ray camera screenRect
        |> Axis3d.intersectionWithPlane (SketchPlane3d.toPlane sourcePlane)
        |> Maybe.map (Point3d.projectInto sourcePlane)


projectEdge : CameraGeometry -> WorldLine -> ScreenLine
projectEdge { camera, screenRect } =
    LineSegment3d.Projection.toScreenSpace camera screenRect


projectPoint : CameraGeometry -> WorldPoint -> ScreenPoint
projectPoint { camera, screenRect } =
    Point3d.Projection.toScreenSpace camera screenRect


inFrontOf : ViewPlane -> WorldPoint -> Bool
inFrontOf =
    SketchPlane3d.normalAxis
        >> Point3d.signedDistanceAlong
        >> (<<) (Quantity.lessThan (Length.meters 0))


isFacingAwayFrom : Viewpoint -> SourcePlane -> Bool
isFacingAwayFrom viewpoint =
    SketchPlane3d.normalDirection
        >> Direction3d.equalWithin (Angle.degrees 90) (Viewpoint3d.viewDirection viewpoint)


isFacingRightOf : Viewpoint -> SourcePlane -> Bool
isFacingRightOf viewpoint =
    SketchPlane3d.normalDirection
        >> Direction3d.projectInto (Viewpoint3d.viewPlane viewpoint)
        >> Maybe.map (Direction2d.xComponent >> flip (<) 0)
        >> Maybe.withDefault False


zVectorFromDirection : Direction -> Vector3d Length.Meters WorldCoordinates
zVectorFromDirection direction =
    let
        multiplier =
            case direction of
                Left ->
                    -1

                Right ->
                    1
    in
    Vector3d.xyz zeroMeters zeroMeters (planeSpacing |> Quantity.multiplyBy multiplier)


makeCameraGeometry : { a | focus : WorldPoint, azimuth : Angle, elevation : Angle, screenDimensions : ( Int, Int ) } -> CameraGeometry
makeCameraGeometry ({ focus, azimuth, elevation, screenDimensions } as model) =
    { camera =
        Camera3d.perspective
            { verticalFieldOfView = verticalFieldOfView
            , viewpoint = makeViewpoint model
            }
    , screenRect = makeScreenRectangle screenDimensions
    }


makeViewpoint : { a | focus : WorldPoint, azimuth : Angle, elevation : Angle } -> Viewpoint3d Length.Meters WorldCoordinates
makeViewpoint { focus, azimuth, elevation } =
    Viewpoint3d.orbit
        { focalPoint = focus
        , groundPlane = SketchPlane3d.xz
        , azimuth = azimuth
        , elevation = elevation
        , distance = viewDistance
        }



-- HELPERS


coordinateDecoder : String -> (Float -> Float -> msg) -> Decoder msg
coordinateDecoder prefix mapper =
    Decode.map2
        mapper
        (Decode.field (prefix ++ "X") <| Decode.float)
        (Decode.field (prefix ++ "Y") <| Decode.float)


{-| Carry a value out of a list at the same time as performing a concatMap
-}
concatMapCarry : (a -> ( c, List b )) -> List a -> ( Maybe c, List b )
concatMapCarry f =
    let
        mapCarrier item ( _, accumulatedList ) =
            f item
                |> Tuple.mapBoth Just ((++) accumulatedList)
    in
    List.foldl mapCarrier ( Nothing, [] )


ziplistInsertBefore : a -> ZipList a -> ZipList a
ziplistInsertBefore x ziplist =
    ZipList.insertBefore x ziplist
        |> ZipList.backward


withNoCmd : Model -> ( Model, Cmd msg )
withNoCmd =
    withCmd Cmd.none


withCmd : Cmd msg -> Model -> ( Model, Cmd msg )
withCmd =
    flip Tuple.pair


reverse : Direction -> Direction
reverse key =
    case key of
        Left ->
            Right

        Right ->
            Left


hsluvToCssColor : Float -> Float -> Float -> Css.Color
hsluvToCssColor h s l =
    let
        { red, green, blue } =
            HSLuv.hsluv
                { hue = h / 255
                , saturation = s
                , lightness = l
                , alpha = 1
                }
                |> HSLuv.toRgba

        toInt =
            (*) 255 >> floor
    in
    Css.rgb
        (toInt red)
        (toInt green)
        (toInt blue)


hsluvToSvgColor : Float -> Float -> Float -> String
hsluvToSvgColor h s l =
    HSLuv.hsluv
        { hue = h / 255
        , saturation = s
        , lightness = l
        , alpha = 1
        }
        |> HSLuv.toColor
        |> Color.toCssString



-- CONSTANTS


theme =
    { dark = Css.hex "13151f"
    , accent = Css.hex "9e3354"
    , light = \hue -> hsluvToCssColor hue 0.5 0.7
    , lighter = \hue -> hsluvToCssColor hue 0.7 0.8
    , initialLayerHue = 90
    }


verticalFieldOfView : Angle
verticalFieldOfView =
    Angle.degrees 50


transitionDuration : Duration
transitionDuration =
    Duration.milliseconds 900


viewDistance : Length.Length
viewDistance =
    Length.centimeters 25


planeSpacing : Length.Length
planeSpacing =
    Length.centimeters 7


layerHueSpacing =
    40


wheelCoefficient =
    0.3


screenMargins =
    10


zeroMeters =
    Length.meters 0



-- DERIVED


makeScreenRectangle : ( Int, Int ) -> Rectangle2d Length.Meters ScreenCoordinates
makeScreenRectangle =
    Tuple.mapBoth (toFloat >> Length.cssPixels) (toFloat >> Length.cssPixels)
        >> uncurry Point2d.xy
        >> Rectangle2d.from Point2d.origin


resolution : Float -> Quantity.Quantity Float (Quantity.Rate Pixels.Pixels Length.Meters)
resolution ratio =
    (48 * ratio)
        |> Pixels.pixels
        |> Quantity.per (Length.inches 1)


subtractScreenMargins ( x, y ) =
    ( x - screenMargins, y - screenMargins )



-- PortFunnel boilerplate


wsCmd : WS.Message -> Cmd Msg
wsCmd =
    WS.send <| getFunnelCmdPort WS.moduleName


wsKey : String
wsKey =
    "api"


getFunnelCmdPort moduleName =
    Funnels.getCmdPort FunnelMsg moduleName False


funnelHandlers : List (Funnels.Handler Model Msg)
funnelHandlers =
    [ Funnels.WebSocketHandler updateFromWebsocket
    ]


funnelDict : Funnels.FunnelDict Model Msg
funnelDict =
    Funnels.makeFunnelDict funnelHandlers <| flip (always getFunnelCmdPort)
