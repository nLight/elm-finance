module Sheet exposing (Model, Msg, view, update, init, add)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, colspan)
import Entry


type alias Model =
    List Entry.Model


init : Model
init =
    [ { name = "Macbook", category = "Work", date = "2016-05-10", amount = 1400 }
    , { name = "Groceries", category = "Groceries", date = "2016-05-10", amount = 25 }
    ]


type Msg
    = Add Entry.Model
    | Delete Int


update : Msg -> Model -> Model
update message model =
    case message of
        Add entry ->
            add entry model

        Delete i ->
            (List.take i model) ++ (List.drop (i + 1) model)


view : Model -> Html Msg
view model =
    table [ class "table" ]
        [ thead []
            [ tr []
                [ th [] [ text "Name" ]
                , th [] [ text "Category" ]
                , th [] [ text "Date" ]
                , th [] [ text "Amount" ]
                , th [] []
                ]
            ]
        , tbody [] (entriesView model ++ [ total model ])
        ]


add : Entry.Model -> Model -> Model
add entry model =
    model ++ [ entry ]


sumAmount : Model -> Float
sumAmount model =
    List.sum (List.map (\e -> e.amount) model)


total : Model -> Html Msg
total model =
    tr []
        [ th [ colspan 3 ] [ text "Total" ]
        , td [] [ text (toString (sumAmount model)) ]
        , td [] []
        ]


entriesView : Model -> List (Html Msg)
entriesView model =
    List.indexedMap entryView model


entryView : Int -> Entry.Model -> Html Msg
entryView i model =
    tr []
        [ td [] [ text model.name ]
        , td [] [ text model.category ]
        , td [] [ text model.date ]
        , td [] [ text (toString model.amount) ]
        , td [] [ button [ class "btn btn-xs btn-default", onClick (Delete i) ] [ text "Delete" ] ]
        ]


main : Program Never
main =
    App.beginnerProgram { model = init, update = update, view = view }
