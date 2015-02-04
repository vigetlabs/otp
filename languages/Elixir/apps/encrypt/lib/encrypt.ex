#!/usr/bin/env elixir

use Bitwise

import OTP.Common

defmodule Encrypt do
  def encrypt([], _), do: []
  def encrypt([ c | cs ], key) do
    [ c ^^^ get_mask(key) | encrypt(cs, Stream.drop(key, 2)) ]
  end 

  def main(argv) do
    IO.read(:line)
    |> to_char_list
    |> encrypt(key(argv))
    |> hex_string_of_ints
    |> IO.write
  end
end
