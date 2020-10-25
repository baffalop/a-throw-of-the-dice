module Main exposing (..)

import Angle exposing (Angle)
import Axis3d exposing (Axis3d)
import Basics.Extra exposing (..)
import Browser
import Browser.Events
import Camera3d exposing (Camera3d)
import Css
import Direction2d
import Html exposing (Html)
import Html.Lazy
import Html.Styled as Styled
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events as StyledEvents
import Json.Decode as Decode exposing (Decoder)
import Keyboard.Event
import Length
import List.Extra
import Path.LowLevel as SvgPath exposing (DrawTo(..), Mode(..), MoveTo(..))
import Pixels
import Point2d exposing (Point2d)
import Point3d exposing (Point3d)
import Point3d.Projection
import Quantity
import Rectangle2d exposing (Rectangle2d)
import Rectangle3d
import SketchPlane3d exposing (SketchPlane3d)
import Svg.Styled as SvgStyled
import Svg.Styled.Attributes as SvgAttr
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
    , focus : Point3d Length.Meters World
    , azimuth : Angle
    , elevation : Angle
    , drawnRect : Maybe DrawnRect
    , devicePixelRatio : Float
    }


type alias DrawnRect =
    { originPoint : SourcePoint
    , rect : Rect
    }


type Msg
    = MouseDown Float Float
    | MouseUp
    | MouseMove Float Float
    | Wheel Float Float
    | CtrlZ
    | NoOp


init : Float -> ( Model, Cmd msg )
init devicePixelRatio =
    let
        xEdge =
            Tuple.first boardSize |> (*) (21.5 / 1000)

        yEdge =
            Tuple.second boardSize |> (*) (18 / 800)

        focusX =
            Tuple.first boardSize |> (*) (13.2 / 1000)

        focusY =
            Tuple.second boardSize |> (*) (10 / 800)
    in
    { rects =
        [ ( 2, 2, 3 )
        , ( 2, yEdge, 3 )
        , ( xEdge, yEdge, 3 )
        , ( xEdge, 2, 3 )
        ]
            |> List.map rectByNumbers
    , sourcePlane = SketchPlane3d.xy
    , focus = Point3d.centimeters focusX focusY 0
    , azimuth = Angle.degrees 90
    , elevation = Angle.degrees 0
    , drawnRect = Nothing
    , devicePixelRatio = devicePixelRatio
    }
        |> withNoCmd


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onKeyDown <|
        Keyboard.Event.considerKeyboardEvent <|
            \{ ctrlKey, metaKey, key } ->
                if (metaKey || ctrlKey) && key == Just "z" then
                    Just CtrlZ

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

            CtrlZ ->
                { model | rects = List.drop 1 model.rects }



-- VIEW


view : Model -> Html Msg
view ({ sourcePlane, rects, drawnRect } as model) =
    let
        camera =
            makeCamera model

        rectHoverCss =
            [ Css.cursor Css.pointer
            , Css.hover
                [ Css.fill <| Css.hex "7da2af"
                ]
            ]

        maybeAppendDrawnRect =
            drawnRect
                |> Maybe.map (viewRect sourcePlane camera [] << .rect)
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
                , Css.borderColor <| Css.hex "732e43"
                , Css.fill <| Css.hex "5a6e75"
                ]
            ]
            [ rects
                |> List.map (viewRect sourcePlane camera rectHoverCss)
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
                    , Css.backgroundColor <| Css.hex "732e43"
                    , Css.color <| Css.hex "13151f"
                    , Css.fontFamilies [ "Fira Code", "monospace" ]
                    ]
                ]
                [ Styled.text "Draw rectangles. Scroll to spin. Ctrl+Z to undo." ]
            ]


viewRect : SourcePlane -> Camera -> List Css.Style -> Rect -> SvgStyled.Svg msg
viewRect plane camera css rect =
    let
        vertices =
            rect
                |> Rectangle3d.on plane
                |> Rectangle3d.vertices
                |> List.map (projectPoint camera)
                |> wrapAround

        cornerRadius =
            Length.centimeters 0.2

        path =
            roundCorners cornerRadius vertices
    in
    SvgStyled.path
        [ SvgAttr.d <| SvgPath.toString path
        , SvgAttr.css css
        ]
        []



-- SVG


roundCorners : Length.Length -> List ScreenPoint -> List SvgPath.SubPath
roundCorners radius points =
    let
        path =
            points
                |> mapPairs (roundedCorner radius)
                |> List.concat

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


roundedCorner : Length.Length -> ScreenPoint -> ScreenPoint -> List DrawTo
roundedCorner radius a b =
    let
        midpoint =
            Point2d.interpolateFrom a b 0.5
    in
    if Point2d.distanceFrom midpoint b |> Quantity.lessThan radius then
        [ QuadraticBezierCurveTo Absolute [ ( svgCoord a, svgCoord midpoint ) ]
        ]

    else
        let
            radiusVector =
                Direction2d.from a b
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
            Vector2d.centimeters 0 0.7

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


projectPoint : Camera -> WorldPoint -> ScreenPoint
projectPoint camera =
    Point3d.Projection.toScreenSpace camera screenRectangle


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


rectByNumbers : ( Float, Float, Float ) -> Rect
rectByNumbers ( x, y, length ) =
    rectFrom (Point2d.centimeters x y) (Point2d.centimeters (x + length) 0)



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


mapPairs : (a -> a -> b) -> List a -> List b
mapPairs f list =
    List.map2 f list (list |> List.drop 1 |> wrapAround)


wrapAround : List a -> List a
wrapAround list =
    case List.head list of
        Nothing ->
            []

        Just head ->
            list ++ [ head ]


withNoCmd : a -> ( a, Cmd msg )
withNoCmd =
    flip Tuple.pair Cmd.none



-- CONSTANTS


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
    Length.centimeters 25


resolution : Float -> Quantity.Quantity Float (Quantity.Rate Pixels.Pixels Length.Meters)
resolution ratio =
    (48 * ratio)
        |> Pixels.pixels
        |> Quantity.per (Length.inches 1)


wheelCoefficient =
    0.3
