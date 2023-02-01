open Stdio

type t = 
  | Command of string
  | Empty
  | Err of exn
  | Start

let readline () = Out_channel.flush Out_channel.stdout;
  try
    match In_channel.input_line In_channel.stdin with
    | None -> Empty
    | Some s -> Command s
  with 
  | e -> Err e
