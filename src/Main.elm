module Main exposing (main)

import Angle
import Axis3d
import Basics.Extra exposing (..)
import Browser
import Css exposing (..)
import Html exposing (Html)
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
import Vector2d
import Vector3d


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
    { rects : List (Rectangle2d Length.Meters TopLeftCoordinates)
    , plane : SketchPlane3d Length.Meters World { defines : TopLeftCoordinates }
    , viewPlane : SketchPlane3d Length.Meters World { defines : TopLeftCoordinates }
    , newRect :
        Maybe
            { originPoint : Point2d Length.Meters TopLeftCoordinates
            , initialX : Float
            , length : Length.Length
            }
    , lockY : Bool
    }


type Msg
    = MouseDown Float Float
    | MouseUp Float Float
    | MouseMove Float Float
    | Wheel Float Float
    | ToggleLockY
    | NoOp


init : () -> ( Model, Cmd msg )
init () =
    { rects =
        [ ( 2, 2, 3 )
        , ( 2, 16, 5 )
        , ( 18, 16, 3 )
        , ( 18, 2, 2 )
        ]
            |> List.map (\( x, y, length ) -> toRectangle (Point2d.centimeters x y) (Length.centimeters length))
    , plane = SketchPlane3d.xy
    , viewPlane =
        SketchPlane3d.xy
            |> SketchPlane3d.offsetBy (Length.meters -3)
            |> SketchPlane3d.rotateAround tiltAxis (Angle.degrees 15)
    , newRect = Nothing
    , lockY = False
    }
        |> withNoCmd


toRectangle : Point2d Length.Meters TopLeftCoordinates -> Length.Length -> Rectangle2d Length.Meters TopLeftCoordinates
toRectangle leftMidPoint length =
    let
        yTranslation =
            Vector2d.centimeters 0 0.75

        xTranslation =
            Vector2d.xy length <| Length.meters 0

        topLeft =
            leftMidPoint
                |> Point2d.translateBy (Vector2d.reverse yTranslation)

        bottomRight =
            leftMidPoint
                |> Point2d.translateBy (yTranslation |> Vector2d.plus xTranslation)
    in
    Rectangle2d.from topLeft bottomRight


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    withNoCmd <|
        case msg of
            NoOp ->
                model

            ToggleLockY ->
                { model | lockY = not model.lockY }

            MouseDown x y ->
                { model
                    | newRect =
                        plotPointAt x y model.plane model.viewPlane
                            |> Maybe.map
                                (\point ->
                                    { originPoint = point
                                    , initialX = x
                                    , length = Length.centimeters 0.1
                                    }
                                )
                }

            MouseMove x y ->
                { model
                    | newRect =
                        model.newRect
                            |> Maybe.map (\rect -> { rect | length = Length.cssPixels <| x - rect.initialX })
                }

            MouseUp x y ->
                { model
                    | newRect = Nothing
                    , rects = includeNewRect model.newRect model.rects
                }

            Wheel deltaX deltaY ->
                let
                    offsetAngleX =
                        Angle.degrees <| negate <| deltaX * wheelCoefficient

                    offsetAngleY =
                        Angle.degrees <| deltaY * wheelCoefficient
                in
                { model
                    | plane =
                        model.plane
                            |> SketchPlane3d.rotateAround turnAxis offsetAngleX
                    , viewPlane =
                        model.viewPlane
                            |> (if model.lockY then
                                    identity

                                else
                                    SketchPlane3d.rotateAround tiltAxis offsetAngleY
                               )
                }


view : Model -> List (Html Msg)
view ({ plane, viewPlane, rects, newRect } as model) =
    List.map Styled.toUnstyled <|
        [ Styled.button
            [ StyledEvents.onClick ToggleLockY
            , css
                [ padding <| px 4
                , margin <| px 10
                ]
            ]
            [ Styled.text <|
                if model.lockY then
                    "Unlock Y"

                else
                    "Lock Y"
            ]
        , Styled.br [] []
        , includeNewRect newRect rects
            |> viewRects plane viewPlane
            |> Svg.Styled.svg
                [ SvgAttr.width "1200px"
                , SvgAttr.height "1200px"
                , StyledEvents.on "mousedown" <| mouseDecoder MouseDown
                , StyledEvents.on "mousemove" <| mouseDecoder MouseMove
                , StyledEvents.on "mouseup" <| mouseDecoder MouseUp
                , StyledEvents.preventDefaultOn "wheel" <| wheelDecoder (\x y -> ( Wheel x y, True ))
                ]
        ]


viewRects plane viewPlane =
    List.map
        (Rectangle3d.on plane
            >> Rectangle3d.vertices
            >> List.map (Point3d.projectInto viewPlane)
            >> viewPolygon
        )


viewPolygon : List (Point2d Length.Meters TopLeftCoordinates) -> Svg.Styled.Svg msg
viewPolygon points =
    Svg.Styled.polygon
        [ SvgAttr.points <| geometryToSvgPoints points
        , SvgAttr.strokeLinejoin "round"
        ]
        []


geometryToSvgPoints : List (Point2d Length.Meters TopLeftCoordinates) -> String
geometryToSvgPoints =
    List.map
        (Point2d.toRecord Length.inCssPixels
            >> (\{ x, y } -> String.fromFloat x ++ "," ++ String.fromFloat y)
        )
        >> String.join " "


plotPointAt :
    Float
    -> Float
    -> SketchPlane3d Length.Meters coordinates { defines : local }
    -> SketchPlane3d Length.Meters coordinates { defines : world }
    -> Maybe (Point2d Length.Meters local)
plotPointAt x y plane viewPlane =
    let
        translationVector =
            Point2d.pixels x y
                |> Point2d.at_
                    (Pixels.pixels 96
                        |> Quantity.per (Length.inches 1)
                    )
                |> Point3d.on viewPlane
                |> Vector3d.from (SketchPlane3d.originPoint viewPlane)
    in
    SketchPlane3d.normalAxis viewPlane
        |> Axis3d.translateBy translationVector
        |> Axis3d.intersectionWithPlane (SketchPlane3d.toPlane plane)
        |> Maybe.map (Point3d.projectInto plane)


includeNewRect :
    Maybe { a | originPoint : Point2d Length.Meters TopLeftCoordinates, length : Length.Length }
    -> List (Rectangle2d Length.Meters TopLeftCoordinates)
    -> List (Rectangle2d Length.Meters TopLeftCoordinates)
includeNewRect newRect rects =
    case newRect of
        Nothing ->
            rects

        Just { originPoint, length } ->
            toRectangle originPoint length :: rects


type TopLeftCoordinates
    = TopLeftCoordinates


type World
    = World


tiltAxis =
    Axis3d.x
        |> Axis3d.translateBy (Vector3d.centimeters 0 25 0)


turnAxis =
    Axis3d.y
        |> Axis3d.translateBy (Vector3d.centimeters 11 0 0)


wheelCoefficient =
    0.3


wheelDecoder : (Float -> Float -> msg) -> Decoder msg
wheelDecoder mapper =
    Decode.map2
        mapper
        (Decode.field "deltaX" <| Decode.float)
        (Decode.field "deltaY" <| Decode.float)


mouseDecoder : (Float -> Float -> msg) -> Decoder msg
mouseDecoder mapper =
    Decode.map2
        mapper
        (Decode.field "offsetX" <| Decode.float)
        (Decode.field "offsetY" <| Decode.float)


withNoCmd : a -> ( a, Cmd msg )
withNoCmd =
    flip Tuple.pair Cmd.none
