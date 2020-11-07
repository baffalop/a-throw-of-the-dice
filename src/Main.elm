module Main exposing (..)

import Angle exposing (Angle)
import Axis3d exposing (Axis3d)
import Basics.Extra exposing (..)
import Browser
import Browser.Events
import Camera3d exposing (Camera3d)
import Css
import Duration exposing (Duration)
import Ease
import Html exposing (Html)
import Html.Styled as Styled
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events as StyledEvents
import Html.Styled.Lazy
import Json.Decode as Decode exposing (Decoder)
import Keyboard.Event
import Length
import LineSegment2d exposing (LineSegment2d)
import LineSegment3d exposing (LineSegment3d)
import LineSegment3d.Projection
import List.Extra
import Path.LowLevel as SvgPath exposing (DrawTo(..), Mode(..), MoveTo(..))
import Pixels
import Point2d exposing (Point2d)
import Point3d exposing (Point3d)
import Quantity
import Rectangle2d exposing (Rectangle2d)
import Rectangle3d exposing (Rectangle3d)
import SketchPlane3d exposing (SketchPlane3d)
import Svg.Styled as SvgStyled
import Svg.Styled.Attributes as SvgAttr
import Svg.Styled.Events
import Vector2d exposing (Vector2d)
import Vector3d
import Viewpoint3d exposing (Viewpoint3d)
import ZipList exposing (ZipList)


main =
    Browser.document
        { init = init
        , view =
            \model ->
                { title = "A wee playabout"
                , body = view model
                }
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { layers : ZipList Layer
    , focus : WorldPoint
    , transition : Maybe Transition
    , azimuth : Angle
    , elevation : Angle
    , drawnRect : Maybe DrawnRect
    , screenDimensions : ( Int, Int )
    , devicePixelRatio : Float
    }


type alias Layer =
    { plane : SourcePlane
    , rects : List Rect
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
    | ArrowKeyPressed ArrowKey
    | CtrlZ
    | NoOp


type ArrowKey
    = Left
    | Right


init : { devicePixelRatio : Float, screenDimensions : ( Int, Int ) } -> ( Model, Cmd msg )
init { devicePixelRatio, screenDimensions } =
    let
        ( screenWidth, screenHeight ) =
            screenDimensions

        focusX =
            toFloat screenWidth * (13.2 / 1000)

        focusY =
            toFloat screenHeight * (10 / 800)
    in
    { layers =
        ZipList.singleton
            { plane = SketchPlane3d.xy
            , rects = []
            }
    , focus = Point3d.centimeters focusX focusY 0
    , transition = Nothing
    , azimuth = Angle.degrees 90
    , elevation = Angle.degrees 0
    , drawnRect = Nothing
    , screenDimensions = screenDimensions
    , devicePixelRatio = devicePixelRatio
    }
        |> withNoCmd


subscriptions : Model -> Sub Msg
subscriptions { transition } =
    Sub.batch
        [ Browser.Events.onKeyDown <|
            Decode.oneOf
                [ ctrlZDecoder CtrlZ
                , arrowKeyDecoder ArrowKeyPressed
                ]
        , Browser.Events.onResize WindowResize
        , case transition of
            Nothing ->
                Sub.none

            Just _ ->
                Browser.Events.onAnimationFrameDelta AnimationTick
        ]


ctrlZDecoder : msg -> Decoder msg
ctrlZDecoder msg =
    Keyboard.Event.considerKeyboardEvent <|
        \{ ctrlKey, metaKey, key } ->
            if (metaKey || ctrlKey) && key == Just "z" then
                Just msg

            else
                Nothing


arrowKeyDecoder : (ArrowKey -> msg) -> Decoder msg
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
    withNoCmd <|
        case msg of
            NoOp ->
                model

            MouseDown x y ->
                let
                    currentLayer =
                        ZipList.current model.layers
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

            MouseMove x y ->
                case model.drawnRect of
                    Nothing ->
                        model

                    Just rect ->
                        let
                            currentLayer =
                                ZipList.current model.layers
                        in
                        { model
                            | drawnRect =
                                ( x, y )
                                    |> raycastTo currentLayer.plane (makeCameraGeometry model) model.devicePixelRatio
                                    |> Maybe.map (\endPoint -> { rect | rect = rectFrom rect.originPoint endPoint })
                        }

            MouseUp ->
                let
                    currentLayer =
                        ZipList.current model.layers
                in
                { model
                    | drawnRect = Nothing
                    , layers =
                        ZipList.replace
                            { currentLayer
                                | rects =
                                    model.drawnRect
                                        |> Maybe.map (.rect >> Rectangle3d.on currentLayer.plane >> flip (::) currentLayer.rects)
                                        |> Maybe.withDefault currentLayer.rects
                            }
                            model.layers
                }

            Wheel deltaX deltaY ->
                let
                    add delta =
                        Angle.inDegrees >> (+) (delta * wheelCoefficient) >> Angle.degrees
                in
                { model
                    | azimuth = model.azimuth |> add deltaX
                    , elevation = model.elevation |> add deltaY
                }

            ClickedTo layerIndex newFocus ->
                let
                    withLayerSet =
                        { model
                            | layers =
                                model.layers
                                    |> ZipList.goToIndex layerIndex
                                    |> Maybe.withDefault model.layers
                        }
                in
                if newFocus |> Point3d.equalWithin (Length.centimeters 0.2) model.focus then
                    withLayerSet

                else
                    withLayerSet |> transitionFocusTo newFocus

            AnimationTick delta ->
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

            ArrowKeyPressed key ->
                let
                    { multiplier, shift, insert } =
                        case key of
                            Left ->
                                { multiplier = 1
                                , shift = ZipList.maybeJumpForward 1
                                , insert = ZipList.insert
                                }

                            Right ->
                                { multiplier = -1
                                , shift = ZipList.maybeJumpBackward 1
                                , insert = ziplistInsertBefore
                                }

                    zVector =
                        Vector3d.xyz zeroMeters zeroMeters (planeSpacing |> Quantity.multiplyBy multiplier)

                    newLayer =
                        { plane =
                            model.layers
                                |> ZipList.current
                                |> .plane
                                |> SketchPlane3d.translateBy zVector
                        , rects = []
                        }

                    newFocus =
                        model.focus |> Point3d.translateBy zVector
                in
                { model
                    | drawnRect = Nothing
                    , layers =
                        shift model.layers
                            |> Maybe.withDefault (insert newLayer model.layers)
                }
                    |> transitionFocusTo newFocus

            CtrlZ ->
                let
                    currentLayer =
                        ZipList.current model.layers
                in
                { model
                    | layers =
                        ZipList.replace
                            { currentLayer | rects = List.drop 1 currentLayer.rects }
                            model.layers
                }


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
    = Focusable
    | Inert


view : Model -> List (Html Msg)
view model =
    List.map Styled.toUnstyled <|
        [ Styled.div
            [ css
                [ Css.position Css.absolute
                , Css.maxWidth <| Css.px 460
                , Css.top <| Css.px 40
                , Css.right <| Css.px 40
                , Css.padding <| Css.px 8
                , Css.backgroundColor theme.accent
                , Css.color theme.dark
                , Css.fontFamilies [ "Fira Code", "monospace" ]
                ]
            ]
            [ nonBreakingTexts
                [ "Draw rectangles."
                , "Scroll to spin."
                , "Click a rectangle to go there."
                , "Ctrl+Z to undo."
                ]
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
            ZipList.current model.layers

        currentLayerIndex =
            ZipList.currentIndex model.layers

        maybeAppendDrawnRect =
            model.drawnRect
                |> Maybe.andThen (.rect >> Rectangle3d.on currentLayer.plane >> viewRect camera Inert currentLayerIndex)
                |> Maybe.map (::)
                |> Maybe.withDefault identity
    in
    model.layers
        |> ZipList.toList
        |> List.indexedMap (viewLayer camera)
        |> List.concat
        |> maybeAppendDrawnRect
        |> SvgStyled.svg
            [ SvgAttr.width <| flip (++) "px" <| String.fromInt screenWidth
            , SvgAttr.height <| flip (++) "px" <| String.fromInt screenHeight
            , StyledEvents.on "mousedown" <| coordinateDecoder "offset" MouseDown
            , StyledEvents.on "mousemove" <| coordinateDecoder "offset" MouseMove
            , StyledEvents.onMouseUp MouseUp
            , StyledEvents.preventDefaultOn "wheel" <| coordinateDecoder "delta" (\x y -> ( Wheel x y, True ))
            , SvgAttr.css
                [ Css.fill theme.light
                , Css.margin <| Css.px 0
                ]
            ]


viewLayer : CameraGeometry -> Int -> Layer -> List (SvgStyled.Svg Msg)
viewLayer camera index { rects } =
    rects
        |> List.filterMap (viewRect camera Focusable index)


viewRect : CameraGeometry -> SvgBehaviour -> Int -> Rect -> Maybe (SvgStyled.Svg Msg)
viewRect cameraGeometry behaviour layerIndex rect =
    if Rectangle3d.vertices rect |> List.all (inFontOf cameraGeometry.camera) then
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
                    Focusable ->
                        [ Svg.Styled.Events.onClick <| ClickedTo layerIndex <| Rectangle3d.centerPoint rect
                        , Svg.Styled.Events.stopPropagationOn "mousedown" <| Decode.succeed ( NoOp, True )
                        , Svg.Styled.Events.stopPropagationOn "mouseup" <| Decode.succeed ( NoOp, True )
                        , SvgAttr.css
                            [ Css.cursor Css.pointer
                            , Css.hover
                                [ Css.fill theme.lighter
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


nonBreakingTexts : List String -> Styled.Html msg
nonBreakingTexts =
    let
        nbsp =
            Char.fromCode 0xA0 |> String.fromChar
    in
    List.map (String.replace " " nbsp)
        >> String.join " "
        >> Styled.text



-- SVG


roundCorners : Length.Length -> List ScreenLine -> List SvgPath.SubPath
roundCorners radius edges =
    let
        path =
            List.concatMap (roundedCornerSegments radius) edges

        endCoords =
            case List.Extra.last path of
                Just (LineTo _ (coords :: _)) ->
                    Just coords

                Just (QuadraticBezierCurveTo _ (( _, coords ) :: _)) ->
                    Just coords

                _ ->
                    Nothing
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


roundedCornerSegments : Length.Length -> ScreenLine -> List DrawTo
roundedCornerSegments radius edge =
    let
        diameter =
            radius |> Quantity.multiplyBy 2

        ( a, b ) =
            LineSegment2d.endpoints edge
    in
    if LineSegment2d.length edge |> Quantity.lessThan diameter then
        [ QuadraticBezierCurveTo Absolute [ ( svgCoord a, svgCoord <| LineSegment2d.midpoint edge ) ]
        ]

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
        in
        [ QuadraticBezierCurveTo Absolute [ ( svgCoord a, svgCoord anchorA ) ]
        , LineTo Absolute [ svgCoord anchorB ]
        ]


svgCoord : ScreenPoint -> ( Float, Float )
svgCoord =
    Point2d.toRecord Length.inCssPixels
        >> (\{ x, y } -> ( x, y ))



-- GEOMETRY


type alias SourcePlane =
    SketchPlane3d Length.Meters World { defines : SourceCoordinates }


type SourceCoordinates
    = SourceCoordinates


type ScreenCoordinates
    = ScreenCoordinates


type World
    = World


type alias SourcePoint =
    Point2d Length.Meters SourceCoordinates


type alias WorldPoint =
    Point3d Length.Meters World


type alias WorldLine =
    LineSegment3d Length.Meters World


type alias ScreenLine =
    LineSegment2d Length.Meters ScreenCoordinates


type alias ScreenPoint =
    Point2d Length.Meters ScreenCoordinates


type alias Camera =
    Camera3d Length.Meters World


type alias CameraGeometry =
    { camera : Camera
    , screenRect : Rectangle2d Length.Meters ScreenCoordinates
    }


type alias Rect =
    Rectangle3d Length.Meters World


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


inFontOf : Camera -> WorldPoint -> Bool
inFontOf =
    Camera3d.viewpoint
        >> Viewpoint3d.viewPlane
        >> SketchPlane3d.normalAxis
        >> Point3d.signedDistanceAlong
        >> (<<) (Quantity.lessThan (Length.meters 0))


makeCameraGeometry : { a | focus : WorldPoint, azimuth : Angle, elevation : Angle, screenDimensions : ( Int, Int ) } -> CameraGeometry
makeCameraGeometry { focus, azimuth, elevation, screenDimensions } =
    { camera =
        Camera3d.perspective
            { verticalFieldOfView = verticalFieldOfView
            , viewpoint =
                Viewpoint3d.orbit
                    { focalPoint = focus
                    , groundPlane = SketchPlane3d.xz
                    , azimuth = azimuth
                    , elevation = elevation
                    , distance = viewDistance
                    }
            }
    , screenRect = makeScreenRectangle screenDimensions
    }



-- HELPERS


coordinateDecoder : String -> (Float -> Float -> msg) -> Decoder msg
coordinateDecoder prefix mapper =
    Decode.map2
        mapper
        (Decode.field (prefix ++ "X") <| Decode.float)
        (Decode.field (prefix ++ "Y") <| Decode.float)


ziplistInsertBefore : a -> ZipList a -> ZipList a
ziplistInsertBefore x ziplist =
    ZipList.insertBefore x ziplist
        |> ZipList.backward


withNoCmd : a -> ( a, Cmd msg )
withNoCmd =
    flip Tuple.pair Cmd.none



-- CONSTANTS


theme =
    { dark = Css.hex "13151f"
    , light = Css.rgba 90 110 117 0.6
    , lighter = Css.rgba 125 162 175 0.6
    , accent = Css.hex "732e43"
    }


verticalFieldOfView : Angle
verticalFieldOfView =
    Angle.degrees 50


transitionDuration : Duration
transitionDuration =
    Duration.milliseconds 900


viewDistance : Length.Length
viewDistance =
    Length.centimeters 30


planeSpacing : Length.Length
planeSpacing =
    Length.centimeters 5


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
