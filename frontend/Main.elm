module Main exposing (Msg(..), main, update, view)

import Browser
import Browser.Events exposing (onAnimationFrame)
import Canvas exposing (rect, shapes)
import Canvas.Settings exposing (fill)
import Color
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Time exposing (posixToMillis)


{-| no flags. model is Model, message is Msg
-}
main : Program () Model Msg
main =
    Browser.element { init = init, subscriptions = subscriptions, update = update, view = view }


width =
    800


height =
    600


colorWhilePlaying : Color.Color
colorWhilePlaying =
    Color.rgb255 139 109 154


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
view { count } =
    div
        [ style "display" "flex"
        , style "justify-content" "center"
        , style "align-items" "center"
        ]
        [ Canvas.toHtml
            ( width, height )
            [ style "border" "10px solid rgba(0,0,0,0.1)" ]
            [ clearScreen
            ]
        ]


clearScreen =
    shapes [ fill colorWhilePlaying ] [ rect ( 0, 0 ) width height ]



-- view model =
-- div []
--     [ button [ onClick (ButtonMsg Decrement) ] [ text "-" ]
--     , div [] [ text (String.fromInt model.count) ]
--     , button [ onClick (ButtonMsg Increment) ] [ text "+" ]
--     , div [] [ text (String.fromFloat (toFloat model.time / 1000.0)) ]
--     , box
--     ]
