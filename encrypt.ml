open Batteries

(* convert two hex chars into an int *)
let int_of_hex_chars c1 c2 = int_of_string (Printf.sprintf "0x%c%c" c1 c2)

(* given a list of numbers, create strings of hex values and concatenate *)
let hex_string_of_ints nums = String.concat "" (List.map (Printf.sprintf "%x") nums)

(* get the mask value for the next two characters of the key *)
let get_mask key =
  let c1 = BatDllist.get key in
  let c2 = BatDllist.get (BatDllist.next key) in
  int_of_hex_chars c1 c2

(* convert the plaintext to int values representing the ciphertext *)
let rec encrypt message key = match message with
  | [] -> []
  | c :: cs -> ((Char.code c) lxor (get_mask key)) :: encrypt cs (BatDllist.skip key 2);;

let key = BatDllist.of_list (String.to_list (Array.get Sys.argv 1)) in
  let message = String.to_list (BatIO.read_line BatIO.stdin) in
  print_string (hex_string_of_ints (encrypt message key))
