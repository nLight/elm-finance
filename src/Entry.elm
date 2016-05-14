module Entry exposing (Model, Msg, update, view)

import Html exposing (..)


type alias Model =
    { name : String, date : String, price : Float }


type Msg
    = NoOp


update : Msg -> Model -> Model
update message model =
    model


view : Model -> Html Msg
view model =
    div [] []
