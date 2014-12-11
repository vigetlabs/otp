open Batteries

(* convert two hex chars into an int *)
let int_from_hex_chars c1 c2 =
  int_of_string ("0x" ^ (String.make 1 c1) ^ (String.make 1 c2))

(* get the mask value for the next two characters of the key *)
let get_mask key =
  let c1 = BatDllist.get key in
  let c2 = BatDllist.get (BatDllist.next key) in
  int_from_hex_chars c1 c2

(* given a list of ints, convert to ASCII char and then concatenate *)
let rec string_from_ints nums = match nums with
  | [] -> ""
  | n :: ns -> (String.make 1 (Char.chr n)) ^ (string_from_ints ns)

(* convert the ciphertext to int values representing the plaintext *)
let rec decrypt ciphertext key = match ciphertext with
  | [] -> []
  | c1 :: c2 :: cs ->
    ((int_from_hex_chars c1 c2) lxor (get_mask key)) :: decrypt cs (BatDllist.skip key 2)
  | _ :: [] -> failwith "Invalid ciphertext";;

let key = BatDllist.of_list (String.to_list (Array.get Sys.argv 1)) in
  let ciphertext = String.to_list (BatIO.read_line BatIO.stdin) in
  print_string (string_from_ints (decrypt ciphertext key))
