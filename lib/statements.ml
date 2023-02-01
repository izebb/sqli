open Base
open Stdio

type status = 
  | Success
  | Unrecognized

type statements = 
  | Insert
  | Select

let execute_prepare_statements s = 
  print_endline s

let execute_meta_statetments = function
  | "exit" -> Caml.exit 0 
  | "table" -> print_endline "showing tables"
  | _ as c' -> printf "Unrecognized command '%s'.\n" c' 

let execute_statements c = 
  if String.is_prefix c ~prefix: "."  then
    execute_meta_statetments (String.chop_prefix_exn c ~prefix: ".")
  else
    execute_prepare_statements c
