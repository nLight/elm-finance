module Entry exposing (Model, Msg, init)


type alias Model =
    { name : String, category : String, date : String, price : Float }


type Msg
    = NoOp


init : Model
init =
    { name = "", category = "", date = "", price = 0 }
