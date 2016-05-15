module AddForm exposing (Model, Msg, view, update)

import Html exposing (..)
import Html.Events exposing (onSubmit, onInput)
import Html.Attributes exposing (type', value)
import Maybe
import Entry


type alias Model =
    Entry.Model


type Msg
    = Update Entry.Field String
    | Submit


update : Msg -> Model -> ( Model, Maybe Model )
update message model =
    case message of
        Submit ->
            ( Entry.init, Just model )

        Update field val ->
            ( Entry.update (Entry.Update field val) model, Nothing )


view : Model -> Html Msg
view model =
    form [ onSubmit Submit ]
        [ div []
            [ label [] [ text "Name" ]
            , input
                [ type' "text"
                , onInput (Update Entry.Name)
                , value model.name
                ]
                []
            ]
        , div []
            [ label [] [ text "Date" ]
            , input
                [ type' "text"
                , onInput (Update Entry.Date')
                , value model.date
                ]
                []
            ]
        , div []
            [ label [] [ text "Price" ]
            , input
                [ type' "text"
                , onInput (Update Entry.Price)
                , value (toString model.price)
                ]
                []
            ]
        , div []
            [ button [ type' "submit" ] [ text "Add" ] ]
        ]
