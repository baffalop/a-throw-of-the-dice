port module WebSocket exposing (CloseData, Error(..), Event(..), sendMsg, sub)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


port sendMsg : Encode.Value -> Cmd msg


port wsSub : (Encode.Value -> msg) -> Sub msg


type Event msg
    = Open
    | Msg msg
    | Error Error
    | Close CloseData


type alias CloseData =
    { code : Int
    , reason : String
    , wasClean : Bool
    }


type Error
    = JsonDecodeError String
    | EventDecodeError Decode.Error
    | WebSocketError


type alias DecodeError =
    { error : String
    , data : String
    }


sub : (Event msga -> msgb) -> Decoder msga -> Sub msgb
sub tag msgDecoder =
    wsSub (processEvent msgDecoder >> tag)


processEvent : Decoder msg -> Encode.Value -> Event msg
processEvent msgDecoder value =
    case Decode.decodeValue (eventDecoder msgDecoder) value of
        Err e ->
            Error <| EventDecodeError e

        Ok event ->
            event


eventDecoder : Decoder msg -> Decoder (Event msg)
eventDecoder msgDecoder =
    Decode.field "event" Decode.string
        |> Decode.andThen
            (\event ->
                case event of
                    "open" ->
                        Decode.succeed Open

                    "msg" ->
                        Decode.map Msg <| Decode.field "msg" msgDecoder

                    "close" ->
                        Decode.map Close closeDecoder

                    "error" ->
                        Decode.map Error <| Decode.field "error" <| Decode.field "type" errorDecoder

                    _ ->
                        Decode.fail <| "Event tag not recognised: " ++ event
            )


errorDecoder : Decoder Error
errorDecoder =
    Decode.string
        |> Decode.andThen
            (\tag ->
                case tag of
                    "json" ->
                        Decode.map JsonDecodeError <| Decode.field "data" Decode.string

                    "ws" ->
                        Decode.succeed WebSocketError

                    _ ->
                        Decode.fail <| "Error tag not recognised: " ++ tag
            )


closeDecoder : Decoder CloseData
closeDecoder =
    Decode.map3
        CloseData
        (Decode.field "code" <| Decode.int)
        (Decode.field "reason" <| Decode.string)
        (Decode.field "wasClean" <| Decode.bool)
