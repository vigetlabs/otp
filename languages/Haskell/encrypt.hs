import Data.Bits(xor)
import Data.Char(ord)
import System.Environment(getArgs)
import Text.Printf(printf)

-- | Convert two hex chars into an int
intOfHexChars :: Char -> Char -> Int
intOfHexChars c1 c2 = read (printf "0x%c%c" c1 c2)

-- | Given a list of numbers, create strings of hex values and concatenate
hexStringOfInts :: [Int] -> [Char]
hexStringOfInts nums = concat (map (printf "%x") nums)

-- | Get the mask value for the next two characters of the key
getMask :: [Char] -> Int -> Int
getMask key idx = intOfHexChars c1 c2
  where
    c1 = key !! mod idx (length key)
    c2 = key !! mod (idx + 1) (length key)

-- | Convert the plaintext to int values representing the ciphertext
encrypt :: [Char] -> [Char] -> Int -> [Int]
encrypt plaintext key idx = case plaintext of
  [] -> []
  c:cs -> xor (ord c) (getMask key idx) : encrypt cs key (idx + 2)

main :: IO ()
main = do
  plaintext <- getLine
  args <- getArgs
  putStr $ hexStringOfInts $ encrypt plaintext (head args) 0
