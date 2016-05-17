module Entry exposing (..)

import String


type alias Model =
    { name : String, category : String, date : String, amount : Float }


type Field
    = Name
    | Date'
    | Category
    | Amount


type Msg
    = Update Field String


init : Model
init =
    { name = "", category = "", date = "", amount = 0 }


update : Msg -> Model -> Model
update message model =
    case message of
        Update Name value ->
            { model | name = value }

        Update Category value ->
            { model | category = value }

        Update Date' value ->
            { model | date = value }

        Update Amount value ->
            case String.toFloat value of
                Ok float ->
                    { model | amount = float }

                Err _ ->
                    model
