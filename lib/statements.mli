open Base

type status = Success | Unrecognized

type statements = Insert | Select

val execute_prepare_statements : string -> unit

val execute_meta_statetments : string -> unit

val execute_statements : string -> unit
