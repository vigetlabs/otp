let rec char_list str = match str with
  "" -> []
| s  -> let len = String.length s in
          let first = String.get s 0 in
          let rest = String.sub s 1 (len -1) in
            first :: char_list rest;;

let int_from_hex_chars c1 c2 =
  int_of_string ("0x" ^ (String.make 1 c1) ^ (String.make 1 c2))

let get_mask key index =
  let c1 = List.nth key (index mod (List.length key)) in
  let c2 = List.nth key ((index + 1) mod (List.length key)) in
    int_from_hex_chars c1 c2

let rec char_join nums = match nums with
  [] -> ""
| n :: ns -> (String.make 1 (Char.chr n)) ^ (char_join ns);;

let rec decrypt ciphertext key index = match ciphertext with
  [] -> []
| c :: [] -> []
| c1 :: c2 :: cs -> let mask = get_mask key index in
  ((int_from_hex_chars c1 c2) lxor mask) :: decrypt cs key (index + 2);;

let key = char_list (Array.get Sys.argv 1) in
  let buffer = String.make 1000 '.' in
  let length = Unix.read Unix.stdin buffer 0 1000 in
  let ciphertext = char_list (String.sub buffer 0 length) in
    print_string (char_join (decrypt ciphertext key 0))
