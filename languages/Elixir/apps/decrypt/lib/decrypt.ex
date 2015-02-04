use Bitwise

import OTP.Common

defmodule Decrypt do
  def decrypt([], _), do: []
  def decrypt([ _ | [] ], _), do: (raise "Invalid ciphertext")
  def decrypt([ c1, c2 | cs ], key) do
    [ int_of_hex_chars([c1, c2]) ^^^ get_mask(key) | decrypt(cs, Stream.drop(key, 2)) ]
  end 

  def main(argv) do
    IO.read(1000)
    |> to_char_list
    |> decrypt(key(argv))
    |> IO.write
  end
end
