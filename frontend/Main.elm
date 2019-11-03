module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


{-| no flags. model is Model, message is Msg
-}
main : Program () Model Msg
main =
    Browser.element { init = init, subscriptions = subscriptions, update = update, view = view }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { count = 0, time = 0 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions i =
    Sub.none


type alias Model =
    { count : Int, time : Float }


type ButtonMsg
    = Increment
    | Decrement


type alias TimeElapsed =
    Float


type Msg
    = ButtonMsgTag ButtonMsg
    | TimeElapsedTag TimeElapsed


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ButtonMsgTag Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        ButtonMsgTag Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        TimeElapsedTag elapsed ->
            ( { model | count = model.count + 1 }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (ButtonMsgTag Decrement) ] [ text "-" ]
        , div [] [ text (String.fromInt model.count) ]
        , button [ onClick (ButtonMsgTag Increment) ] [ text "+" ]
        ]
