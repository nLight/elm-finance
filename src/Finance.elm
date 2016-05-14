module Finance exposing (..)

import Html.App
import Html exposing (..)
import Sheet


type alias Model =
    Sheet.Model


type Msg
    = NoOp


update : Msg -> Model -> Model
update message model =
    model


init : Sheet.Model
init =
    Sheet.model


view : Model -> Html Msg
view model =
    Html.App.map (\_ -> NoOp) (Sheet.view model)


main : Program Never
main =
    Html.App.beginnerProgram { model = init, view = view, update = update }
