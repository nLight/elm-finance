module Sheet exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (class)
import Entry


type alias Model =
    List Entry.Model


model : Model
model =
    [ { name = "Macbook", date = "2016-05-10", price = 1400 }
    , { name = "Groceries", date = "2016-05-10", price = 25 }
    ]


type Msg
    = NoOp


view : Model -> Html Msg
view model =
    table []
        [ thead []
            [ tr []
                [ th [] [ text "Name" ]
                , th [] [ text "Date" ]
                , th [] [ text "Price" ]
                ]
            ]
        , entriesView model
        ]


entriesView : Model -> Html Msg
entriesView model =
    tbody [] (List.map entryView model)


entryView : Entry.Model -> Html Msg
entryView model =
    Html.App.map (\_ -> NoOp)
        (tr []
            [ td [] [ text model.name ]
            , td [] [ text model.date ]
            , td [] [ text (toString model.price) ]
            ]
        )
