open Batteries

(* convert two hex chars into an int *)
let int_of_hex_chars c1 c2 = int_of_string (Printf.sprintf "0x%c%c" c1 c2)

(* given a list of numbers, create strings of hex values and concatenate *)
let hex_string_of_ints nums = String.concat "" (List.map (Printf.sprintf "%x") nums)

(* get the mask value for the next two characters of the key *)
let get_mask key =
  let c1 = Dllist.get key
  and c2 = Dllist.get (Dllist.next key) in
  int_of_hex_chars c1 c2

(* convert the plaintext to int values representing the ciphertext *)
let rec encrypt message key = match message with
  | [] -> []
  | c :: cs -> (Char.code c) lxor (get_mask key) :: encrypt cs (Dllist.skip key 2);;

let key = Dllist.of_list (String.to_list (Array.get Sys.argv 1))
  and message = String.to_list (IO.read_line IO.stdin) in
  print_string (hex_string_of_ints (encrypt message key))
