module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


{-| no flags. model is Int, message is Msg
-}
main : Program () Int Msg
main =
    Browser.element { init = init, subscriptions = subscriptions, update = update, view = view }


init : () -> ( Int, Cmd Msg )
init _ =
    ( 0, Cmd.none )


subscriptions : Int -> Sub Msg
subscriptions i =
    Sub.none


type Msg
    = Increment
    | Decrement


update : Msg -> Int -> ( Int, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )


view : Int -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]
