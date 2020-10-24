module Main exposing (..)

import Angle
import Axis3d
import Basics.Extra exposing (..)
import Browser
import Css exposing (..)
import Direction2d
import Html exposing (Html)
import Html.Lazy
import Html.Styled as Styled
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events as StyledEvents
import Json.Decode as Decode exposing (Decoder)
import Length
import Pixels
import Point2d exposing (Point2d)
import Point3d
import Quantity
import Rectangle2d exposing (Rectangle2d)
import Rectangle3d
import SketchPlane3d exposing (SketchPlane3d)
import Svg.Styled
import Svg.Styled.Attributes as SvgAttr
import Vector2d exposing (Vector2d)
import Vector3d


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
    , viewPlane : ViewPlane
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
    | NoOp


init : Float -> ( Model, Cmd msg )
init devicePixelRatio =
    { rects =
        [ ( 2, 2, 3 )
        , ( 2, 18, 3 )
        , ( 21, 18, 3 )
        , ( 21, 2, 3 )
        ]
            |> List.map rectByNumbers
    , sourcePlane = SketchPlane3d.xy
    , viewPlane =
        SketchPlane3d.xy
            |> SketchPlane3d.offsetBy (Length.meters -3)
            |> SketchPlane3d.rotateAround tiltAxis (Angle.degrees 20)
    , drawnRect = Nothing
    , devicePixelRatio = devicePixelRatio
    }
        |> withNoCmd


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


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
                            |> plottedOn model.sourcePlane model.viewPlane model.devicePixelRatio
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
                                    |> plottedOn model.sourcePlane model.viewPlane model.devicePixelRatio
                                    |> Maybe.map (\endPoint -> { rect | rect = rectFrom rect.originPoint endPoint })
                        }

            MouseUp ->
                { model
                    | drawnRect = Nothing
                    , rects = includeDrawnRect model.drawnRect model.rects
                }

            Wheel deltaX deltaY ->
                let
                    offsetAngleX =
                        Angle.degrees <| negate <| deltaX * wheelCoefficient

                    offsetAngleY =
                        Angle.degrees <| deltaY * wheelCoefficient
                in
                { model
                    | sourcePlane =
                        model.sourcePlane
                            |> SketchPlane3d.rotateAround turnAxis offsetAngleY
                }



-- VIEW


view : Model -> Html Msg
view { sourcePlane, viewPlane, rects, drawnRect } =
    Styled.toUnstyled <|
        Styled.div
            [ css
                [ display inlineBlock
                , margin <| px 30
                , border <| px 4
                , borderStyle <| solid
                , borderColor <| hex "732e43"
                , fill <| hex "5a6e75"
                ]
            ]
            [ includeDrawnRect drawnRect rects
                |> List.map (viewRect sourcePlane viewPlane)
                |> Svg.Styled.svg
                    [ SvgAttr.width "1000px"
                    , SvgAttr.height "800px"
                    , StyledEvents.on "mousedown" <| coordinateDecoder "offset" MouseDown
                    , StyledEvents.on "mousemove" <| coordinateDecoder "offset" MouseMove
                    , StyledEvents.onMouseUp MouseUp
                    , StyledEvents.preventDefaultOn "wheel" <| coordinateDecoder "delta" (\x y -> ( Wheel x y, True ))
                    ]
            ]


viewRect : SourcePlane -> ViewPlane -> Rect -> Svg.Styled.Svg msg
viewRect plane viewPlane rect =
    let
        vertices =
            rect
                |> Rectangle3d.on plane
                |> Rectangle3d.vertices
                |> List.map (Point3d.projectInto viewPlane)

        path =
            roundCorners (Length.centimeters 0.3) vertices
                |> cycle1
    in
    Svg.Styled.path
        [ SvgAttr.d <| svgClosedPath path
        ]
        []



-- SVG


type SplinePoint
    = LinePoint ViewPoint
    | AnchorPoint ViewPoint


type alias Spline =
    List SplinePoint


roundCorners : Length.Length -> List ViewPoint -> Spline
roundCorners radius =
    mapPairs (roundCorner radius) >> List.concat


roundCorner : Length.Length -> ViewPoint -> ViewPoint -> Spline
roundCorner radius a b =
    let
        midpoint =
            Point2d.interpolateFrom a b 0.5
    in
    if Point2d.distanceFrom midpoint b |> Quantity.lessThan radius then
        [ LinePoint midpoint
        , AnchorPoint b
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
        [ LinePoint anchorA
        , LinePoint anchorB
        , AnchorPoint b
        ]


svgCoord : ViewPoint -> String
svgCoord =
    Point2d.toRecord Length.inCssPixels
        >> (\{ x, y } -> String.fromFloat x ++ "," ++ String.fromFloat y)


svgClosedPath : Spline -> String
svgClosedPath spline =
    let
        printPoints a b =
            case ( a, b ) of
                ( LinePoint _, LinePoint point ) ->
                    "L" ++ svgCoord point

                ( AnchorPoint _, LinePoint point ) ->
                    svgCoord point

                ( _, AnchorPoint point ) ->
                    "Q" ++ svgCoord point

        first =
            case List.head spline of
                Just (LinePoint point) ->
                    svgCoord point

                _ ->
                    ""
    in
    spline
        |> cycle1
        |> mapPairs printPoints
        |> (::) first
        |> String.join " "
        |> (\s -> "M " ++ s ++ " Z")



-- GEOMETRY


type alias SourcePlane =
    SketchPlane3d Length.Meters World { defines : SourceCoordinates }


type alias ViewPlane =
    SketchPlane3d Length.Meters World { defines : ViewCoordinates }


type SourceCoordinates
    = SourceCoordinates


type ViewCoordinates
    = ViewCoordinates


type World
    = World


type alias SourcePoint =
    Point2d Length.Meters SourceCoordinates


type alias ViewPoint =
    Point2d Length.Meters ViewCoordinates


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


plottedOn : SourcePlane -> ViewPlane -> Float -> ( Float, Float ) -> Maybe SourcePoint
plottedOn sourcePlane viewPlane pixelRatio ( x, y ) =
    let
        translationVector =
            Point2d.pixels x y
                |> Point2d.at_ (resolution pixelRatio)
                |> Point3d.on viewPlane
                |> Vector3d.from (SketchPlane3d.originPoint viewPlane)
    in
    SketchPlane3d.normalAxis viewPlane
        |> Axis3d.translateBy translationVector
        |> Axis3d.intersectionWithPlane (SketchPlane3d.toPlane sourcePlane)
        |> Maybe.map (Point3d.projectInto sourcePlane)


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
    list
        |> cycle1
        |> List.drop 1
        |> List.map2 f list


cycle1 : List a -> List a
cycle1 list =
    list ++ (List.head list |> Maybe.map List.singleton |> Maybe.withDefault [])


withNoCmd : a -> ( a, Cmd msg )
withNoCmd =
    flip Tuple.pair Cmd.none



-- CONSTANTS


tiltAxis =
    Axis3d.x
        |> Axis3d.translateBy (Vector3d.centimeters 0 21 0)


turnAxis =
    Axis3d.y
        |> Axis3d.translateBy (Vector3d.centimeters 13 0 0)


resolution : Float -> Quantity.Quantity Float (Quantity.Rate Pixels.Pixels Length.Meters)
resolution ratio =
    (48 * ratio)
        |> Pixels.pixels
        |> Quantity.per (Length.inches 1)


wheelCoefficient =
    0.3
