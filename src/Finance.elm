module Finance exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (class)
import Sheet
import Entry
import AddForm


type alias Model =
    { form : AddForm.Model
    , sheet : Sheet.Model
    }


type Msg
    = FormMsg AddForm.Msg
    | SheetMsg Sheet.Msg


update : Msg -> Model -> Model
update message model =
    case message of
        FormMsg formMsg ->
            case AddForm.update formMsg model.form of
                ( newForm, Just entry ) ->
                    { model
                        | form = newForm
                        , sheet = Sheet.add entry model.sheet
                    }

                ( newForm, Nothing ) ->
                    { model | form = newForm }

        SheetMsg sheetMsg ->
            { model | sheet = (Sheet.update sheetMsg model.sheet) }


init : Model
init =
    { form = Entry.init, sheet = Sheet.init }


view : Model -> Html Msg
view model =
    div [ class "wrapper" ]
        [ header [ class "main-header" ] []
        , aside [ class "main-sidebar" ] []
        , div [ class "content-wrapper" ]
            [ section [ class "content" ]
                [ div [ class "box box-default" ]
                    [ div [ class "box-header" ] [ h3 [ class "box-title" ] [ text "Add new Entry" ] ]
                    , div [ class "box-body" ] [ App.map FormMsg (AddForm.view model.form) ]
                    ]
                , div [ class "box box-default" ]
                    [ div [ class "box-header" ] [ h3 [ class "box-title" ] [ text "Spendings" ] ]
                    , div [ class "box-body" ] [ App.map SheetMsg (Sheet.view model.sheet) ]
                    ]
                ]
            ]
        ]


main : Program Never
main =
    App.beginnerProgram { model = init, update = update, view = view }
