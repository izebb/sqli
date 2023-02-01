open Base
open Stdio
open Inputs
open Statements

let print_prompt () = 
  printf "sqli > "

let run () =
  let rec _run input_t =  
    match input_t with
    | Start | Empty -> 
        print_prompt ();
        _run (readline ())
    | Err e -> raise e
    | Command c ->
        execute_statements c;
        _run Start
  in 
  _run Start
