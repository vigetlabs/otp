(* convert string to list of chars *)
let rec char_list str = match str with
  | "" -> []
  | s  -> String.get s 0 :: char_list (String.sub s 1 ((String.length s) - 1))

(* convert two hex chars into an int *)
let int_from_hex_chars c1 c2 =
  int_of_string ("0x" ^ (String.make 1 c1) ^ (String.make 1 c2))

(* get the mask value at the given index *)
let get_mask key index =
  let c1 = List.nth key (index mod (List.length key)) in
  let c2 = List.nth key ((index + 1) mod (List.length key)) in
  int_from_hex_chars c1 c2

(* given a list of numbers, create strings of hex values and concatenate *)
let rec hex_string nums = match nums with
  | [] -> ""
  | n :: ns -> Printf.sprintf "%x" n ^ hex_string ns

(* convert the plaintext to int values representing the ciphertext *)
let rec encrypt message key index = match message with
  | [] -> []
  | c :: cs -> ((Char.code c) lxor (get_mask key index)) :: encrypt cs key (index + 2);;

let key = char_list (Array.get Sys.argv 1) in
  let buffer = String.make 1000 '.' in
  let length = Unix.read Unix.stdin buffer 0 1000 in
  let message = char_list (String.sub buffer 0 length) in
  print_string (hex_string (encrypt message key 0))
