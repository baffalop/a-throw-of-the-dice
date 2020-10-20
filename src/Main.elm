module Main exposing (main)

import Angle
import Axis3d
import Basics.Extra exposing (..)
import Browser
import Browser.Events
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
import SketchPlane3d exposing (SketchPlane3d)
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
    { points : List (Point2d Length.Meters TopLeftCoordinates)
    , plane : SketchPlane3d Length.Meters World { defines : TopLeftCoordinates }
    , viewPlane : SketchPlane3d Length.Meters World { defines : TopLeftCoordinates }
    , mouse : MouseState
    , lockY : Bool
    }


type MouseState
    = Up
    | Down
        { firstX : Float
        , firstY : Float
        , lastX : Float
        , lastY : Float
        }


type Msg
    = MouseDown Float Float
    | MouseUp Float Float
    | MouseMove Float Float
    | ToggleLockY
    | NoOp


init : () -> ( Model, Cmd msg )
init () =
    { points =
        [ ( 2, 2 )
        , ( 2, 16 )
        , ( 18, 16 )
        , ( 18, 2 )
        ]
            |> List.map (uncurry Point2d.centimeters)
    , plane = SketchPlane3d.xy
    , viewPlane =
        SketchPlane3d.xy
            |> SketchPlane3d.offsetBy (Length.meters -3)
            |> SketchPlane3d.rotateAround tiltAxis (Angle.degrees 15)
    , mouse = Up
    , lockY = False
    }
        |> withNoCmd


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onMouseDown <| mouseDecoder MouseDown
        , Browser.Events.onMouseMove <| mouseDecoder MouseMove
        , Browser.Events.onMouseUp <| mouseDecoder MouseUp
        ]


mouseDecoder : (Float -> Float -> msg) -> Decoder msg
mouseDecoder mapper =
    Decode.map2
        mapper
        (Decode.field "offsetX" <| Decode.float)
        (Decode.field "offsetY" <| Decode.float)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model |> withNoCmd

        ToggleLockY ->
            { model | lockY = not model.lockY }
                |> withNoCmd

        MouseDown x y ->
            { model
                | mouse =
                    Down
                        { firstX = x
                        , firstY = y
                        , lastX = x
                        , lastY = y
                        }
            }
                |> withNoCmd

        MouseMove x y ->
            case model.mouse of
                Up ->
                    model |> withNoCmd

                Down ({ lastX, lastY } as mouseCoords) ->
                    let
                        offsetAngleX =
                            Angle.degrees <| (x - lastX) / 4

                        offsetAngleY =
                            Angle.degrees <| negate <| (y - lastY) / 4
                    in
                    { model
                        | mouse = Down { mouseCoords | lastX = x, lastY = y }
                        , plane =
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
                        |> withNoCmd

        MouseUp x y ->
            case model.mouse of
                Up ->
                    model |> withNoCmd

                Down { firstX, firstY } ->
                    let
                        withMouseUp =
                            { model | mouse = Up }
                    in
                    if abs (x - firstX) < 2 && abs (y - firstY) < 2 then
                        case plotPointAt x y model.plane model.viewPlane of
                            Nothing ->
                                withMouseUp |> withNoCmd

                            Just point ->
                                { withMouseUp | points = point :: model.points }
                                    |> withNoCmd

                    else
                        withMouseUp
                            |> withNoCmd


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


view : Model -> List (Html Msg)
view { points, plane, viewPlane, lockY } =
    List.map Styled.toUnstyled <|
        Styled.button
            [ StyledEvents.onClick ToggleLockY
            , StyledEvents.stopPropagationOn "mouseup" <| Decode.succeed ( NoOp, True )
            , StyledEvents.stopPropagationOn "mousedown" <| Decode.succeed ( NoOp, True )
            , css
                [ padding <| px 4
                , margin <| px 10
                ]
            ]
            [ Styled.text <|
                if lockY then
                    "Unlock Y"

                else
                    "Lock Y"
            ]
            :: (points
                    |> List.map
                        (Point3d.on plane
                            >> Point3d.projectInto viewPlane
                            >> viewPoint
                        )
               )


viewPoint : Point2d Length.Meters TopLeftCoordinates -> Styled.Html msg
viewPoint point =
    let
        { x, y } =
            Point2d.toRecord Length.inCssPixels point

        size =
            px 10
    in
    Styled.div
        [ css
            [ position absolute
            , backgroundColor <| hex "777777"
            , borderRadius <| pct 100
            , width size
            , height size
            , left <| px x
            , top <| px y
            , transforms
                [ translateX <| pct -50
                , translateY <| pct -50
                ]
            ]
        ]
        []


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


withNoCmd : a -> ( a, Cmd msg )
withNoCmd =
    flip Tuple.pair Cmd.none
