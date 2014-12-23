import Data.Bits(xor)
import Data.Char(chr)
import System.Environment(getArgs)
import Text.Printf(printf)

intOfHexChars c1 c2 = read (printf "0x%c%c" c1 c2)

stringOfInts nums = map chr nums 

getMask key idx = intOfHexChars c1 c2
  where
    c1 = key !! mod idx (length key)
    c2 = key !! mod (idx + 1) (length key)

decrypt ciphertext key idx = case ciphertext of
  [] -> []
  c1:c2:cs -> xor (intOfHexChars c1 c2) (getMask key idx) : decrypt cs key (idx + 2)

main = do
  plaintext <- getLine
  args <- getArgs
  putStr (stringOfInts (decrypt plaintext (head args) 0))
