#!/usr/bin/env elixir

use Bitwise

defmodule Decrypt do
  def int_of_hex_chars([c1, c2]) do
    String.to_integer << c1, c2 >>, 16
  end

  def get_mask(key) do
    Enum.take(key, 2) |> int_of_hex_chars
  end

  def decrypt([], _), do: []
  def decrypt([ _ | [] ], _), do: (raise "Invalid ciphertext")

  def decrypt([ c1, c2 | cs ], key) do
    [ int_of_hex_chars([c1, c2]) ^^^ get_mask(key) | decrypt(cs, Stream.drop(key, 2)) ]
  end 

  def main(argv) do
    key = argv |> List.first |> to_char_list |> Stream.cycle

    IO.read(1000)
    |> to_char_list
    |> decrypt(key)
    |> IO.write
  end
end
