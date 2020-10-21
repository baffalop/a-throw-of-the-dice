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
import Vector2d exposing (Vector2d)
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


type alias Plane =
    SketchPlane3d Length.Meters World { defines : TopLeftCoordinates }


type alias PlanePoint =
    Point2d Length.Meters TopLeftCoordinates


type alias Rect =
    Rectangle2d Length.Meters TopLeftCoordinates


type alias Model =
    { rects : List (Rectangle2d Length.Meters TopLeftCoordinates)
    , sourcePlane : Plane
    , viewPlane : Plane
    , drawnRect :
        Maybe DrawnRect
    , lockY : Bool
    }


type alias DrawnRect =
    { originPoint : PlanePoint
    , rect : Rect
    }


type Msg
    = MouseDown Float Float
    | MouseUp
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
            |> List.map (\( x, y, length ) -> rectFrom (Point2d.centimeters x y) (Point2d.centimeters (x + length) 0))
    , sourcePlane = SketchPlane3d.xy
    , viewPlane =
        SketchPlane3d.xy
            |> SketchPlane3d.offsetBy (Length.meters -3)
            |> SketchPlane3d.rotateAround tiltAxis (Angle.degrees 20)
    , drawnRect = Nothing
    , lockY = True
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

            ToggleLockY ->
                { model | lockY = not model.lockY }

            MouseDown x y ->
                { model
                    | drawnRect =
                        ( x, y )
                            |> plottedOn model.sourcePlane model.viewPlane
                            |> Maybe.map
                                (\point ->
                                    { originPoint = point
                                    , rect = rectFrom point point
                                    }
                                )
                }

            MouseMove x y ->
                { model
                    | drawnRect =
                        Maybe.map2
                            (\rect endPoint -> { rect | rect = rectFrom rect.originPoint endPoint })
                            model.drawnRect
                            (( x, y ) |> plottedOn model.sourcePlane model.viewPlane)
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
                            |> SketchPlane3d.rotateAround turnAxis offsetAngleX
                    , viewPlane =
                        model.viewPlane
                            |> (if model.lockY then
                                    identity

                                else
                                    SketchPlane3d.rotateAround tiltAxis offsetAngleY
                               )
                }



-- VIEW


view : Model -> List (Html Msg)
view ({ sourcePlane, viewPlane, rects, drawnRect } as model) =
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
        , includeDrawnRect drawnRect rects
            |> viewRects sourcePlane viewPlane
            |> Svg.Styled.svg
                [ SvgAttr.width "1200px"
                , SvgAttr.height "1200px"
                , StyledEvents.on "mousedown" <| mouseDecoder MouseDown
                , StyledEvents.on "mousemove" <| mouseDecoder MouseMove
                , StyledEvents.onMouseUp MouseUp
                , StyledEvents.preventDefaultOn "wheel" <| wheelDecoder (\x y -> ( Wheel x y, True ))
                ]
        ]


viewRects : Plane -> Plane -> List Rect -> List (Svg.Styled.Svg msg)
viewRects plane viewPlane =
    List.map
        (Rectangle3d.on plane
            >> Rectangle3d.vertices
            >> List.map (Point3d.projectInto viewPlane)
            >> viewPolygon
        )


viewPolygon : List PlanePoint -> Svg.Styled.Svg msg
viewPolygon points =
    Svg.Styled.polygon
        [ SvgAttr.points <| geometryToSvgPoints points
        , SvgAttr.strokeLinejoin "round"
        ]
        []


geometryToSvgPoints : List PlanePoint -> String
geometryToSvgPoints =
    List.map
        (Point2d.toRecord Length.inCssPixels
            >> (\{ x, y } -> String.fromFloat x ++ "," ++ String.fromFloat y)
        )
        >> String.join " "



-- GEOMETRY


rectFrom : PlanePoint -> PlanePoint -> Rect
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


plottedOn : Plane -> Plane -> ( Float, Float ) -> Maybe PlanePoint
plottedOn sourcePlane viewPlane ( x, y ) =
    let
        translationVector =
            Point2d.pixels x y
                |> Point2d.at_ pixelDensity
                |> Point3d.on viewPlane
                |> Vector3d.from (SketchPlane3d.originPoint viewPlane)
    in
    SketchPlane3d.normalAxis viewPlane
        |> Axis3d.translateBy translationVector
        |> Axis3d.intersectionWithPlane (SketchPlane3d.toPlane sourcePlane)
        |> Maybe.map (Point3d.projectInto sourcePlane)


includeDrawnRect : Maybe DrawnRect -> List Rect -> List Rect
includeDrawnRect newRect rects =
    case newRect of
        Nothing ->
            rects

        Just { rect } ->
            rect :: rects


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


pixelDensity =
    Pixels.pixels 96
        |> Quantity.per (Length.inches 1)


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
