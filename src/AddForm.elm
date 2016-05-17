module AddForm exposing (Model, Msg, view, update)

import Html exposing (..)
import Html.Events exposing (onSubmit, onInput)
import Html.Attributes exposing (class, type', value)
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
        [ div [ class "form-group" ]
            [ label [] [ text "Name" ]
            , input
                [ class "form-control"
                , type' "text"
                , onInput (Update Entry.Name)
                , value model.name
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label [] [ text "Date" ]
            , input
                [ class "form-control"
                , type' "text"
                , onInput (Update Entry.Date')
                , value model.date
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label [] [ text "Price" ]
            , input
                [ class "form-control"
                , type' "text"
                , onInput (Update Entry.Amount)
                , value (toString model.amount)
                ]
                []
            ]
        , div []
            [ button [ class "btn btn-primary", type' "submit" ] [ text "Add" ] ]
        ]
