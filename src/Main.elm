module Main exposing (..)

import Angle exposing (Angle)
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
import Keyboard.Event
import Length
import LineSegment2d exposing (LineSegment2d)
import LineSegment3d exposing (LineSegment3d)
import LineSegment3d.Projection
import List.Extra
import Path.LowLevel as SvgPath exposing (DrawTo(..), Mode(..), MoveTo(..))
import Pixels
import Poem
import Point2d exposing (Point2d)
import Point3d exposing (Point3d)
import Point3d.Projection
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
                { title = "One Toss of the Mouse"
                , body = view model
                }
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { layers : ZipList Layer
    , focus : WorldPoint
    , azimuth : Angle
    , elevation : Angle
    , drag : Movement
    , transition : Maybe Transition
    , tooltip : Maybe { text : String, mouseX : Float, mouseY : Float }
    , screenDimensions : ( Int, Int )
    , devicePixelRatio : Float
    }


type alias Layer =
    { plane : SourcePlane
    , spans : List Span
    }


type alias Span =
    { text : Maybe String
    , rect : Rect
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
    | MouseOverText String Float Float
    | MouseOut
    | AnimationTick Float
    | WindowResize Int Int
    | ArrowKeyPressed ArrowKey
    | CtrlZ
    | NoOp


type Movement
    = Stationary
    | Momentum Float Float
    | Grabbed
        { lastX : Float
        , lastY : Float
        , x : Float
        , y : Float
        }


type ArrowKey
    = Left
    | Right


init : { devicePixelRatio : Float, screenDimensions : ( Int, Int ) } -> ( Model, Cmd msg )
init { devicePixelRatio, screenDimensions } =
    let
        sourcePlane =
            SketchPlane3d.xy
    in
    { layers = initLayers sourcePlane <| Poem.pair Poem.pages
    , focus = centrePoint |> Point3d.on sourcePlane
    , azimuth = Angle.degrees -90
    , elevation = Angle.degrees 180
    , drag = Stationary
    , transition = Nothing
    , tooltip = Nothing
    , screenDimensions = screenDimensions
    , devicePixelRatio = devicePixelRatio
    }
        |> withNoCmd


initLayers : SourcePlane -> List (List Poem.Span) -> ZipList Layer
initLayers originPlane =
    List.indexedMap
        (\index page ->
            let
                zVector =
                    planeSpacing
                        |> Quantity.multiplyBy (toFloat index * -1)
                        |> Vector3d.xyz zeroMeters zeroMeters

                plane =
                    originPlane |> SketchPlane3d.translateBy zVector
            in
            { plane = plane
            , spans = List.map (spanToSpan plane) page
            }
        )
        >> ZipList.fromList
        >> Maybe.withDefault
            (ZipList.singleton
                { plane = originPlane
                , spans = []
                }
            )


spanToSpan : SourcePlane -> Poem.Span -> Span
spanToSpan plane { x, y, width, height, text } =
    let
        ( floatX, floatY ) =
            ( toFloat x * scaling, toFloat y * scaling )

        ( floatWidth, floatHeight ) =
            ( toFloat width * scaling, toFloat height * scaling )
    in
    Rectangle2d.with
        { x1 = Length.millimeters floatX
        , y1 = Length.millimeters floatY
        , x2 = Length.millimeters (floatX + floatWidth)
        , y2 = Length.millimeters (floatY + floatHeight)
        }
        |> Rectangle3d.on plane
        |> Span (Just text)


subscriptions : Model -> Sub Msg
subscriptions { transition, drag } =
    Sub.batch
        [ Browser.Events.onKeyDown <|
            Decode.oneOf
                [ ctrlZDecoder CtrlZ
                , arrowKeyDecoder ArrowKeyPressed
                ]
        , Browser.Events.onResize WindowResize
        , case drag of
            Momentum _ _ ->
                Browser.Events.onAnimationFrameDelta AnimationTick

            _ ->
                case transition of
                    Just _ ->
                        Browser.Events.onAnimationFrameDelta AnimationTick

                    Nothing ->
                        Sub.none
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
                { model
                    | drag = Grabbed { x = x, y = y, lastX = x, lastY = y }
                    , tooltip = Nothing
                }

            MouseMove x y ->
                let
                    withMappedTooltip =
                        { model | tooltip = Maybe.map (\popover -> { popover | mouseX = x, mouseY = y }) model.tooltip }
                in
                case model.drag of
                    Grabbed grab ->
                        let
                            ( deltaX, deltaY ) =
                                ( x - grab.x, y - grab.y )
                        in
                        { withMappedTooltip
                            | drag = Grabbed { lastX = grab.x, lastY = grab.y, x = x, y = y }
                            , azimuth = dragAngle deltaX model.azimuth
                            , elevation = dragAngle -deltaY model.elevation
                        }

                    _ ->
                        withMappedTooltip

            MouseUp ->
                case model.drag of
                    Grabbed { lastX, lastY, x, y } ->
                        { model | drag = Momentum (x - lastX) (y - lastY) }

                    _ ->
                        model

            Wheel deltaX deltaY ->
                let
                    add delta =
                        Angle.inDegrees >> (+) (delta * dragCoefficient) >> Angle.degrees
                in
                { model
                    | azimuth = add deltaX model.azimuth
                    , elevation = add deltaY model.elevation
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

            MouseOverText text x y ->
                case model.transition of
                    Nothing ->
                        case model.drag of
                            Grabbed _ ->
                                model

                            _ ->
                                { model | tooltip = Just { text = text, mouseX = x, mouseY = y } }

                    _ ->
                        model

            MouseOut ->
                { model | tooltip = Nothing }

            AnimationTick delta ->
                model |> tickMomentum delta |> tickTransition delta

            WindowResize width height ->
                { model | screenDimensions = ( width, height ) }

            ArrowKeyPressed key ->
                let
                    currentLayer =
                        ZipList.current model.layers

                    planesAreFacingRight =
                        ZipList.current model.layers
                            |> .plane
                            |> isFacingRightOf (makeViewpoint model)

                    direction =
                        if planesAreFacingRight then
                            key

                        else
                            reverse key

                    { multiplier, shift, insert } =
                        case direction of
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
                        { plane = currentLayer.plane |> SketchPlane3d.translateBy zVector
                        , spans = []
                        }

                    newFocus =
                        model.focus |> Point3d.translateBy zVector
                in
                { model | layers = shift model.layers |> Maybe.withDefault (insert newLayer model.layers) }
                    |> transitionFocusTo newFocus

            CtrlZ ->
                let
                    currentLayer =
                        ZipList.current model.layers
                in
                { model
                    | layers =
                        ZipList.replace
                            { currentLayer | spans = List.drop 1 currentLayer.spans }
                            model.layers
                }


tickMomentum : Float -> Model -> Model
tickMomentum delta model =
    case model.drag of
        Momentum momentumX momentumY ->
            let
                deltaDecay =
                    movementDecay ^ delta

                ( decayedX, decayedY ) =
                    ( momentumX * deltaDecay, momentumY * deltaDecay )

                threshold =
                    0.2
            in
            { model
                | drag =
                    if decayedX < threshold && decayedY < threshold then
                        Stationary

                    else
                        Momentum decayedX decayedY
                , azimuth = dragAngle momentumX model.azimuth
                , elevation = dragAngle -momentumY model.elevation
            }

        _ ->
            model


tickTransition : Float -> Model -> Model
tickTransition delta model =
    case model.transition of
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

        Nothing ->
            model


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
                [ "Scroll or click and drag to look around."
                , "Click a rectangle to go there."
                , "Hover over a rectangle to see text."
                , "Ctrl+Z to undo."
                ]
            ]
        , Html.Styled.Lazy.lazy viewSvg model
        , case ( model.transition, model.tooltip ) of
            ( Nothing, Just { text, mouseX, mouseY } ) ->
                Styled.div
                    [ css
                        [ Css.position Css.absolute
                        , Css.left <| Css.px mouseX
                        , Css.transform <| Css.translateX <| Css.pct -50
                        , Css.top <| Css.px <| mouseY - 50
                        , Css.padding <| Css.px 6
                        , Css.backgroundColor theme.accent
                        , Css.color theme.dark
                        , Css.fontFamilies [ "Fira Code", "monospace" ]
                        , Css.pointerEvents Css.none
                        ]
                    ]
                    [ Styled.text text ]

            _ ->
                Styled.text ""
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

        currentIndex =
            ZipList.currentIndex model.layers

        focusRect =
            layerDimensions
                |> Vector2d.components
                |> Rectangle2d.centeredOn (Frame2d.atPoint centrePoint)
                |> Rectangle3d.on currentLayer.plane
    in
    model.layers
        |> ZipList.toList
        |> indexedFilterMap (viewLayer camera)
        |> List.sortBy (negate << .depth)
        |> List.map .svg
        |> (::) (viewFocusRect camera currentIndex focusRect)
        |> SvgStyled.svg
            [ SvgAttr.width <| flip (++) "px" <| String.fromInt screenWidth
            , SvgAttr.height <| flip (++) "px" <| String.fromInt screenHeight
            , StyledEvents.on "mousemove" <| coordinateDecoder "offset" MouseMove
            , StyledEvents.on "mousedown" <| coordinateDecoder "offset" MouseDown
            , StyledEvents.onMouseUp MouseUp
            , StyledEvents.preventDefaultOn "wheel" <| coordinateDecoder "delta" (\x y -> ( Wheel x y, True ))
            ]


viewLayer : CameraGeometry -> Int -> Layer -> Maybe { depth : Float, svg : SvgStyled.Svg Msg }
viewLayer camera index { plane, spans } =
    let
        depth =
            Camera3d.viewpoint camera.camera
                |> Viewpoint3d.eyePoint
                |> Point3d.signedDistanceFrom (SketchPlane3d.toPlane plane)
                |> Length.inMeters
                |> abs

        fade =
            (1.4 - depth * 1.3)
                |> clamp 0 1
                |> sqrt
    in
    if fade == 0 then
        Nothing

    else
        let
            hue =
                hueFromIndex index

            svg =
                spans
                    |> List.filterMap (viewSpan camera (Focusable index <| theme.lighter hue fade))
                    |> SvgStyled.g
                        [ SvgAttr.css
                            [ Css.fill <| theme.light hue fade
                            , Css.margin <| Css.px 0
                            ]
                        ]
        in
        Just { depth = depth, svg = svg }


viewSpan : CameraGeometry -> SvgBehaviour -> Span -> Maybe (SvgStyled.Svg Msg)
viewSpan cameraGeometry behaviour { rect, text } =
    let
        viewPlane =
            cameraGeometry.camera
                |> Camera3d.viewpoint
                |> Viewpoint3d.viewPlane

        hoverEvents =
            case text of
                Just text_ ->
                    [ Svg.Styled.Events.on "mouseover" <| coordinateDecoder "offset" <| MouseOverText text_
                    , Svg.Styled.Events.onMouseOut MouseOut
                    ]

                Nothing ->
                    []
    in
    if Rectangle3d.vertices rect |> List.all (inFrontOf viewPlane) then
        let
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
                            ++ hoverEvents

                    Inert ->
                        []
        in
        Just <|
            SvgStyled.path
                (SvgAttr.d (SvgPath.toString path) :: attributes)
                []

    else
        Nothing


viewFocusRect : CameraGeometry -> Int -> Rect -> SvgStyled.Svg msg
viewFocusRect cameraGeometry index rect =
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
        , SvgAttr.stroke <| hsluvToSvgColor (hueFromIndex index) 0.7 0.5
        , SvgAttr.strokeWidth "2"
        , SvgAttr.strokeDasharray "8 6"
        , SvgAttr.fillOpacity "0"
        ]
        []


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



-- GEOMETRY


type alias SourcePlane =
    SketchPlane3d Length.Meters World { defines : SourceCoordinates }


type alias ViewPlane =
    SketchPlane3d Length.Meters World { defines : ScreenCoordinates }


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


type alias Viewpoint =
    Viewpoint3d Length.Meters World


type alias CameraGeometry =
    { camera : Camera
    , screenRect : Rectangle2d Length.Meters ScreenCoordinates
    }


type alias Rect =
    Rectangle3d Length.Meters World


type alias PlaneRect =
    Rectangle2d Length.Meters SourceCoordinates


dragAngle : Float -> Angle -> Angle
dragAngle delta =
    Angle.inDegrees >> (+) (delta * dragCoefficient) >> Angle.degrees


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


makeCameraGeometry : { a | focus : WorldPoint, azimuth : Angle, elevation : Angle, screenDimensions : ( Int, Int ) } -> CameraGeometry
makeCameraGeometry ({ focus, azimuth, elevation, screenDimensions } as model) =
    { camera =
        Camera3d.perspective
            { verticalFieldOfView = verticalFieldOfView
            , viewpoint = makeViewpoint model
            }
    , screenRect = makeScreenRectangle screenDimensions
    }


makeViewpoint : { a | focus : WorldPoint, azimuth : Angle, elevation : Angle } -> Viewpoint3d Length.Meters World
makeViewpoint { focus, azimuth, elevation } =
    Viewpoint3d.orbit
        { focalPoint = focus
        , groundPlane = SketchPlane3d.xz
        , azimuth = azimuth
        , elevation = elevation
        , distance = viewDistance
        }



-- COLOURS


theme =
    { dark = Css.hex "13151f"
    , accent = Css.hex "9e3354"
    , light = \hue fade -> hsluvToCssColor hue (0.3 * fade + 0.2) (0.6 * fade + 0.1)
    , lighter = \hue fade -> hsluvToCssColor hue (0.3 * fade + 0.3) (0.7 * fade + 0.1)
    , initialLayerHue = 90
    }


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


hueFromIndex : Int -> Float
hueFromIndex i =
    theme.initialLayerHue
        |> (+) (i * layerHueSpacing)
        |> modBy 256
        |> toFloat



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


indexedFilterMap : (Int -> a -> Maybe b) -> List a -> List b
indexedFilterMap f =
    List.foldl
        (\item ( index, result ) ->
            f index item
                |> Maybe.map (flip (::) result)
                |> Maybe.withDefault result
                |> Tuple.pair (index + 1)
        )
        ( 0, [] )
        >> Tuple.second
        >> List.reverse


ziplistInsertBefore : a -> ZipList a -> ZipList a
ziplistInsertBefore x ziplist =
    ZipList.insertBefore x ziplist
        |> ZipList.backward


withNoCmd : a -> ( a, Cmd msg )
withNoCmd =
    flip Tuple.pair Cmd.none


reverse : ArrowKey -> ArrowKey
reverse key =
    case key of
        Left ->
            Right

        Right ->
            Left



-- CONSTANTS


verticalFieldOfView : Angle
verticalFieldOfView =
    Angle.degrees 70


transitionDuration : Duration
transitionDuration =
    Duration.milliseconds 900


viewDistance : Length.Length
viewDistance =
    Length.centimeters 20


planeSpacing : Length.Length
planeSpacing =
    Length.centimeters 12


scaling =
    0.4


layerDimensions : Vector2d Length.Meters SourceCoordinates
layerDimensions =
    Vector2d.millimeters (954 * scaling) (792 * scaling)


centrePoint : SourcePoint
centrePoint =
    Vector2d.interpolateFrom Vector2d.zero layerDimensions 0.5
        |> Vector2d.components
        |> uncurry Point2d.xy


cornerRadius =
    Length.centimeters 0.1


layerHueSpacing =
    30


dragCoefficient =
    0.3


movementDecay =
    0.9 ^ (1 / 25)


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
