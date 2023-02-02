open Base

type operation_status = Insert_success

type table = { mutable num_rows : Base.int; pages : string array; }

val table_max_pages : int

val new_table : unit -> table

val insert : table -> string -> operation_status
