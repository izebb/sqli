open Base
open Stdio

open Table

type meta_statements = 
  | Meta_statement_exit
  | Meta_statement_table
  | Meta_statement_unrecognized of string

type prepare_statements = 
  | Insert of string list
  | Select of string list
  | Unrecognized 

type prepare_statement_status =
  | Prepare_success_statement
  | Prepare_error_statement
  | Prepare_unrecognized_statement of string

let prepare_statement_handler = function
  | Prepare_success_statement -> print_endline "Executed successfully"
  | Prepare_error_statement -> printf "Syntax error. Could not parse statement."
  | Prepare_unrecognized_statement s -> printf "Unrecognized keyword at start of '%s'.\n" s

let meta_statement_handler = function
  | Meta_statement_exit -> Caml.exit 0
  | Meta_statement_table -> printf "showing tables\n"
  | Meta_statement_unrecognized s -> printf "Unrecognized command '%s'.\n" s 

let get_prepare_command s =
  String.split s ~on: ' '
  |> List.map ~f: String.strip
  |> List.filter ~f: (fun s' -> not (String.(=) s' ""))

let prepare_variant = function
  | "insert" :: t -> Insert t
  | "select" :: t -> Select t
  | _ -> Unrecognized

let serialize id username email = 
  `Assoc
    [
      ("id", `String id);
      ("username", `String username);
      ("email",`String email);
    ]
  |> Yojson.Basic.pretty_to_string


let execute_insert table stmt = 
  match stmt with 
    | id :: username :: email :: _ ->
        (match insert table (serialize id username email)  
          with
          | Insert_success -> Prepare_success_statement)
    | _ -> Prepare_error_statement

let execute_prepare_statements table stmt = 
  let stmt' = get_prepare_command stmt in
  match prepare_variant stmt' with
  | Insert s -> execute_insert table s
  | Select s -> execute_insert table s
  | Unrecognized -> Prepare_unrecognized_statement stmt

let execute_meta_statetments _ = function
  | "exit" -> Meta_statement_exit 
  | "table" -> Meta_statement_table
  | _ as c -> Meta_statement_unrecognized c

let execute_statements table stmt = 
  let stmt' = String.strip stmt in
  if String.is_prefix stmt' ~prefix: "."  then
     execute_meta_statetments table (String.chop_prefix_exn stmt' ~prefix: ".") |> meta_statement_handler
  else
     execute_prepare_statements table stmt' |> prepare_statement_handler
