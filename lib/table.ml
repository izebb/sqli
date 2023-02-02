open Base

type operation_status = 
  | Insert_success

type table = {
  mutable num_rows : int;
  pages : string array;
}

let table_max_pages = 100

let new_table () =
  {
    num_rows = 0;
    pages = (Array.create ~len:table_max_pages "");
  }

let insert table content = 
  begin
    table.pages.(table.num_rows) <- content;
    table.num_rows <- table.num_rows + 1;
    Insert_success
  end
