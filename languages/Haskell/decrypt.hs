import Data.Bits(xor)
import Data.Char(chr)
import System.Environment(getArgs)
import Text.Printf(printf)

-- | Convert two hex chars into an int
intOfHexChars :: [Char] -> Int
intOfHexChars cs = read $ printf "0x%c%c" c1 c2 where [c1, c2] = cs

-- | Get the mask value for the next two characters of the key
getMask :: [Char] -> Int
getMask key = intOfHexChars $ take 2 key

-- | Convert the ciphertext to int values representing the plaintext
decrypt :: [Char] -> [Char] -> [Int]
decrypt ciphertext key = case ciphertext of
  []       -> []
  _:[]     -> error "Invalid ciphertext"
  c1:c2:cs -> xor (intOfHexChars [c1, c2]) (getMask key) : decrypt cs (drop 2 key)

main :: IO ()
main = do
  plaintext <- getLine
  args <- getArgs
  putStr $ map chr $ decrypt plaintext $ cycle $ head args
