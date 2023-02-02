open Base
open Stdio
open Inputs
open Statements
open Table

let print_prompt () = 
  printf "sqli > "

let run () =
  let table = new_table () in

  let rec _run input_t =  
    match input_t with
    | Start | Empty -> 
        print_prompt ();
        _run (readline ())
    | Err e -> raise e
    | Command c ->
        execute_statements table c;
        _run Start
  in
  _run Start
