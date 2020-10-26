module Main exposing (..)

import Angle exposing (Angle)
import Axis3d exposing (Axis3d)
import Basics.Extra exposing (..)
import Browser
import Browser.Events
import Camera3d exposing (Camera3d)
import Css
import Ease
import Html exposing (Html)
import Html.Lazy
import Html.Styled as Styled
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events as StyledEvents
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
import Viewpoint3d exposing (Viewpoint3d)


main =
    Browser.document
        { init = init
        , view =
            \model ->
                { title = "A wee playabout"
                , body = Html.Lazy.lazy view model |> List.singleton
                }
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { rects : List Rect
    , sourcePlane : SourcePlane
    , focus : WorldPoint
    , transition : Maybe Transition
    , azimuth : Angle
    , elevation : Angle
    , drawnRect : Maybe DrawnRect
    , devicePixelRatio : Float
    }


type alias DrawnRect =
    { originPoint : SourcePoint
    , rect : Rect
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
    | ClickedTo WorldPoint
    | AnimationTick Float
    | CtrlZ
    | NoOp


init : Float -> ( Model, Cmd msg )
init devicePixelRatio =
    let
        focusX =
            Tuple.first boardSize |> (*) (13.2 / 1000)

        focusY =
            Tuple.second boardSize |> (*) (10 / 800)
    in
    { rects = []
    , sourcePlane = SketchPlane3d.xy
    , focus = Point3d.centimeters focusX focusY 0
    , transition = Nothing
    , azimuth = Angle.degrees 90
    , elevation = Angle.degrees 0
    , drawnRect = Nothing
    , devicePixelRatio = devicePixelRatio
    }
        |> withNoCmd


subscriptions : Model -> Sub Msg
subscriptions { transition } =
    Sub.batch
        [ onCtrlZ CtrlZ
        , case transition of
            Nothing ->
                Sub.none

            Just _ ->
                Browser.Events.onAnimationFrameDelta AnimationTick
        ]


onCtrlZ : msg -> Sub msg
onCtrlZ msg =
    Browser.Events.onKeyDown <|
        Keyboard.Event.considerKeyboardEvent <|
            \{ ctrlKey, metaKey, key } ->
                if (metaKey || ctrlKey) && key == Just "z" then
                    Just msg

                else
                    Nothing


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    withNoCmd <|
        case msg of
            NoOp ->
                model

            MouseDown x y ->
                { model
                    | drawnRect =
                        ( x, y )
                            |> raycastTo model.sourcePlane (makeCamera model) model.devicePixelRatio
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
                        { model
                            | drawnRect =
                                ( x, y )
                                    |> raycastTo model.sourcePlane (makeCamera model) model.devicePixelRatio
                                    |> Maybe.map (\endPoint -> { rect | rect = rectFrom rect.originPoint endPoint })
                        }

            MouseUp ->
                { model
                    | drawnRect = Nothing
                    , rects = includeDrawnRect model.drawnRect model.rects
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

            ClickedTo newFocus ->
                if newFocus |> Point3d.equalWithin (Length.centimeters 0.2) model.focus then
                    model

                else
                    { model
                        | transition =
                            Just
                                { from = model.focus
                                , to = newFocus
                                , at = 0
                                }
                    }

            AnimationTick delta ->
                case model.transition of
                    Nothing ->
                        model

                    Just ({ from, to } as transition) ->
                        let
                            at =
                                transition.at + (delta / 800)
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

            CtrlZ ->
                { model | rects = List.drop 1 model.rects }



-- VIEW


type SvgBehaviour
    = Focusable
    | Inert


view : Model -> Html Msg
view ({ sourcePlane, rects, drawnRect } as model) =
    let
        camera =
            makeCamera model

        maybeAppendDrawnRect =
            drawnRect
                |> Maybe.andThen (.rect >> Rectangle3d.on sourcePlane >> viewRect camera Inert)
                |> Maybe.map (::)
                |> Maybe.withDefault identity
    in
    Styled.toUnstyled <|
        Styled.div
            [ css
                [ Css.display Css.inlineBlock
                , Css.margin <| Css.px 30
                , Css.padding <| Css.px 0
                , Css.border <| Css.px 4
                , Css.borderStyle <| Css.solid
                , Css.borderColor theme.accent
                , Css.fill theme.light
                ]
            ]
            [ rects
                |> List.filterMap (Rectangle3d.on sourcePlane >> viewRect camera Focusable)
                |> maybeAppendDrawnRect
                |> SvgStyled.svg
                    [ SvgAttr.width <| flip (++) "px" <| String.fromInt <| Tuple.first boardSize
                    , SvgAttr.height <| flip (++) "px" <| String.fromInt <| Tuple.second boardSize
                    , StyledEvents.on "mousedown" <| coordinateDecoder "offset" MouseDown
                    , StyledEvents.on "mousemove" <| coordinateDecoder "offset" MouseMove
                    , StyledEvents.onMouseUp MouseUp
                    , StyledEvents.preventDefaultOn "wheel" <| coordinateDecoder "delta" (\x y -> ( Wheel x y, True ))
                    ]
            , Styled.div
                [ css
                    [ Css.display Css.block
                    , Css.padding <| Css.px 8
                    , Css.backgroundColor theme.accent
                    , Css.color theme.dark
                    , Css.fontFamilies [ "Fira Code", "monospace" ]
                    ]
                ]
                [ Styled.text "Draw rectangles. Scroll to spin. Ctrl+Z to undo." ]
            ]


viewRect : Camera -> SvgBehaviour -> Rectangle3d Length.Meters World -> Maybe (SvgStyled.Svg Msg)
viewRect camera behaviour rect =
    if rect |> Rectangle3d.vertices |> areAllInFontOf camera then
        let
            cornerRadius =
                Length.centimeters 0.2

            path =
                rect
                    |> Rectangle3d.edges
                    |> List.map (projectEdge camera)
                    |> roundCorners cornerRadius

            attributes =
                case behaviour of
                    Focusable ->
                        [ Svg.Styled.Events.onClick <| ClickedTo <| Rectangle3d.centerPoint rect
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



-- SVG


roundCorners : Length.Length -> List ScreenEdge -> List SvgPath.SubPath
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


roundedCornerSegments : Length.Length -> ScreenEdge -> List DrawTo
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


type alias WorldEdge =
    LineSegment3d Length.Meters World


type alias ScreenEdge =
    LineSegment2d Length.Meters ScreenCoordinates


type alias ScreenPoint =
    Point2d Length.Meters ScreenCoordinates


type alias Camera =
    Camera3d Length.Meters World


type alias Rect =
    Rectangle2d Length.Meters SourceCoordinates


rectFrom : SourcePoint -> SourcePoint -> Rect
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


raycastTo : SourcePlane -> Camera -> Float -> ( Float, Float ) -> Maybe SourcePoint
raycastTo sourcePlane camera pixelRatio ( x, y ) =
    Point2d.pixels x y
        |> Point2d.at_ (resolution pixelRatio)
        |> Camera3d.ray camera screenRectangle
        |> Axis3d.intersectionWithPlane (SketchPlane3d.toPlane sourcePlane)
        |> Maybe.map (Point3d.projectInto sourcePlane)


projectEdge : Camera -> WorldEdge -> ScreenEdge
projectEdge camera =
    LineSegment3d.Projection.toScreenSpace camera screenRectangle


areAllInFontOf : Camera -> List WorldPoint -> Bool
areAllInFontOf =
    Camera3d.viewpoint
        >> Viewpoint3d.viewPlane
        >> SketchPlane3d.normalAxis
        >> Point3d.signedDistanceAlong
        >> (<<) (Quantity.lessThan (Length.meters 0))
        >> List.all


makeCamera : { a | focus : WorldPoint, azimuth : Angle, elevation : Angle } -> Camera
makeCamera { focus, azimuth, elevation } =
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



-- HELPERS


includeDrawnRect : Maybe DrawnRect -> List Rect -> List Rect
includeDrawnRect newRect rects =
    case newRect of
        Nothing ->
            rects

        Just { rect } ->
            rect :: rects


coordinateDecoder : String -> (Float -> Float -> msg) -> Decoder msg
coordinateDecoder prefix mapper =
    Decode.map2
        mapper
        (Decode.field (prefix ++ "X") <| Decode.float)
        (Decode.field (prefix ++ "Y") <| Decode.float)


withNoCmd : a -> ( a, Cmd msg )
withNoCmd =
    flip Tuple.pair Cmd.none



-- CONSTANTS


theme =
    { dark = Css.hex "13151f"
    , light = Css.hex "5a6e75"
    , lighter = Css.hex "7da2af"
    , accent = Css.hex "732e43"
    }


boardSize =
    ( 700, 600 )


screenRectangle : Rectangle2d Length.Meters ScreenCoordinates
screenRectangle =
    boardSize
        |> Tuple.mapBoth Length.cssPixels Length.cssPixels
        |> uncurry Point2d.xy
        |> Rectangle2d.from Point2d.origin


verticalFieldOfView : Angle
verticalFieldOfView =
    Angle.degrees 50


viewDistance : Length.Length
viewDistance =
    Length.centimeters 20


resolution : Float -> Quantity.Quantity Float (Quantity.Rate Pixels.Pixels Length.Meters)
resolution ratio =
    (48 * ratio)
        |> Pixels.pixels
        |> Quantity.per (Length.inches 1)


wheelCoefficient =
    0.3
