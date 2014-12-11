open Batteries

(* convert two hex chars into an int *)
let int_of_hex_chars c1 c2 = int_of_string (Printf.sprintf "0x%c%c" c1 c2)

(* given a list of ints, convert to ASCII char and then concatenate *)
let string_of_ints nums = String.of_list (List.map Char.chr nums)

(* get the mask value for the next two characters of the key *)
let get_mask key =
  let c1 = BatDllist.get key in
  let c2 = BatDllist.get (BatDllist.next key) in
  int_of_hex_chars c1 c2

(* convert the ciphertext to int values representing the plaintext *)
let rec decrypt ciphertext key = match ciphertext with
  | [] -> []
  | c1 :: c2 :: cs ->
    (int_of_hex_chars c1 c2) lxor (get_mask key) :: decrypt cs (BatDllist.skip key 2)
  | _ :: [] -> failwith "Invalid ciphertext";;

let key = BatDllist.of_list (String.to_list (Array.get Sys.argv 1)) in
  let ciphertext = String.to_list (BatIO.read_line BatIO.stdin) in
  print_string (string_of_ints (decrypt ciphertext key))
