import System.Environment(getArgs)

encrypt plaintext key = case plaintext of
  [] -> ""
  c:cs -> '*' : encrypt cs key

main = do
  plaintext <- getLine
  args <- getArgs
  putStrLn (encrypt plaintext (head args))
