import Data.Bits(xor)
import Data.Char(ord)
import System.Environment(getArgs)
import Text.Printf(printf)

-- | Convert two hex chars into an int
intOfHexChars :: [Char] -> Int
intOfHexChars cs = read $ printf "0x%c%c" c1 c2 where [c1, c2] = cs

-- | Given a list of numbers, create strings of hex values and concatenate
hexStringOfInts :: [Int] -> [Char]
hexStringOfInts nums = concat $ map (printf "%x") nums

-- | Get the mask value for the next two characters of the key
getMask :: [Char] -> Int
getMask key = intOfHexChars $ take 2 key

-- | Convert the plaintext to int values representing the ciphertext
encrypt :: [Char] -> [Char] -> [Int]
encrypt plaintext key = case plaintext of
  []   -> []
  c:cs -> xor (ord c) (getMask key) : encrypt cs (drop 2 key)

main :: IO ()
main = do
  plaintext <- getLine
  args <- getArgs
  putStr $ hexStringOfInts $ encrypt plaintext $ cycle $ head args
