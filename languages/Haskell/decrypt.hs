import Data.Bits(xor)
import Data.Char(chr)
import System.Environment(getArgs)
import Text.Printf(printf)

int_of_hex_chars c1 c2 = read (printf "0x%c%c" c1 c2)

string_of_ints nums = map chr nums 

get_mask key idx = int_of_hex_chars c1 c2
  where
    c1 = key !! mod idx (length key)
    c2 = key !! mod (idx + 1) (length key)

decrypt ciphertext key idx = case ciphertext of
  [] -> []
  c1:c2:cs -> xor (int_of_hex_chars c1 c2) (get_mask key idx) : decrypt cs key (idx + 2)

main = do
  plaintext <- getLine
  args <- getArgs
  putStr (string_of_ints (decrypt plaintext (head args) 0))
