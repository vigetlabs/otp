import Data.Bits(xor)
import Data.Char(ord)
import Data.List(concat)
import System.Environment(getArgs)
import Text.Printf(printf)

-- convert two hex chars into an int
intOfHexChars c1 c2 = read (printf "0x%c%c" c1 c2)

-- given a list of numbers, create strings of hex values and concatenate
hexStringOfInts nums = concat (map (printf "%x") nums)

-- get the mask value for the next two characters of the key
getMask key idx = intOfHexChars c1 c2
  where
    c1 = key !! mod idx (length key)
    c2 = key !! mod (idx + 1) (length key)

-- convert the plaintext to int values representing the ciphertext
encrypt plaintext key idx = case plaintext of
  [] -> []
  c:cs -> xor (ord c) (getMask key idx) : encrypt cs key (idx + 2)

main = do
  plaintext <- getLine
  args <- getArgs
  putStr (hexStringOfInts (encrypt plaintext (head args) 0))
