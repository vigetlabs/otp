import Data.Bits(xor)
import Data.Char(ord)
import Data.List(concat)
import System.Environment(getArgs)
import Text.Printf(printf)

intOfHexChars c1 c2 = read (printf "0x%c%c" c1 c2)

hexStringOfInts nums = concat (map (printf "%x") nums)

getMask key idx = intOfHexChars c1 c2
  where
    c1 = key !! mod idx (length key)
    c2 = key !! mod (idx + 1) (length key)

encrypt plaintext key idx = case plaintext of
  [] -> []
  c:cs -> xor (ord c) (getMask key idx) : encrypt cs key (idx + 2)

main = do
  plaintext <- getLine
  args <- getArgs
  putStr (hexStringOfInts (encrypt plaintext (head args) 0))
