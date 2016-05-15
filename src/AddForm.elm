module AddForm exposing (Model, Msg, view, update)

import Html exposing (..)
import Html.Events exposing (onSubmit, onInput)
import Html.Attributes exposing (type', value)
import Maybe
import String
import Entry


type alias Model =
    Entry.Model


type Field
    = Name
    | Date'
    | Price


type Msg
    = Update Field String
    | Submit


update : Msg -> Model -> ( Model, Maybe Model )
update message model =
    case message of
        Submit ->
            ( Entry.init, Just model )

        Update Name value ->
            ( { model | name = value }, Nothing )

        Update Date' value ->
            ( { model | date = value }, Nothing )

        Update Price value ->
            case String.toFloat value of
                Ok float ->
                    ( { model | price = float }, Nothing )

                Err _ ->
                    ( model, Nothing )


view : Model -> Html Msg
view model =
    form [ onSubmit Submit ]
        [ div []
            [ label [] [ text "Name" ]
            , input
                [ type' "text"
                , onInput (Update Name)
                , value model.name
                ]
                []
            ]
        , div []
            [ label [] [ text "Date" ]
            , input
                [ type' "text"
                , onInput (Update Date')
                , value model.date
                ]
                []
            ]
        , div []
            [ label [] [ text "Price" ]
            , input
                [ type' "text"
                , onInput (Update Price)
                , value (toString model.price)
                ]
                []
            ]
        , div []
            [ button [ type' "submit" ] [ text "Add" ] ]
        ]