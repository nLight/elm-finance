module Finance exposing (..)

import Html.App as App
import Html exposing (..)
import Platform.Cmd as Cmd exposing (..)
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


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        FormMsg formMsg ->
            case AddForm.update formMsg model.form of
                ( newForm, _, Just entry ) ->
                    let
                        newSheet =
                            Sheet.add entry model.sheet
                    in
                        ( { model | form = newForm, sheet = newSheet }
                        , none
                        )

                ( newForm, _, Nothing ) ->
                    ( { model | form = newForm }
                    , none
                    )

        SheetMsg sheetMsg ->
            ( { model | sheet = (Sheet.update sheetMsg model.sheet) }
            , none
            )


init : ( Model, Cmd Msg )
init =
    ( { form = Entry.init, sheet = Sheet.init }
    , none
    )


view : Model -> Html Msg
view model =
    div []
        [ div [] [ App.map FormMsg (AddForm.view model.form) ]
        , div [] [ App.map SheetMsg (Sheet.view model.sheet) ]
        ]


main : Program Never
main =
    App.program { init = init, update = update, view = view, subscriptions = \_ -> Sub.none }
