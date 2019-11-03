module Main exposing (Msg(..), main, update, view)

import Browser
import Browser.Events exposing (onAnimationFrame)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Time exposing (posixToMillis)


{-| no flags. model is Model, message is Msg
-}
main : Program () Model Msg
main =
    Browser.element { init = init, subscriptions = subscriptions, update = update, view = view }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { count = 0, time = 0 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions m =
    posixToMillis >> TimeMsg |> onAnimationFrame


type alias Model =
    { count : Int, time : Int }


type ButtonMsg
    = Increment
    | Decrement


type alias CurrentTimeMillis =
    Int


type Msg
    = ButtonMsg ButtonMsg
    | TimeMsg CurrentTimeMillis


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ButtonMsg Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        ButtonMsg Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        TimeMsg currTime ->
            ( { model | time = currTime }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (ButtonMsg Decrement) ] [ text "-" ]
        , div [] [ text (String.fromInt model.count) ]
        , button [ onClick (ButtonMsg Increment) ] [ text "+" ]
        , div [] [ text (String.fromFloat (toFloat model.time / 1000.0)) ]
        ]
