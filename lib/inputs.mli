type t = 
  | Command of string 
  | Empty 
  | Err of exn 
  | Start

val readline : unit -> t
