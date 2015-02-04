#!/usr/bin/env elixir

use Bitwise

defmodule Encrypt do
  def int_of_hex_chars([c1, c2]) do
    String.to_integer << c1, c2 >>, 16
  end

  def hex_string_of_ints(ints) do
    Enum.map ints, &(&1 |> Integer.to_string(16) |> String.downcase)
  end

  def get_mask(key) do
    Enum.take(key, 2) |> int_of_hex_chars
  end

  def encrypt([], _), do: []

  def encrypt([ c | cs ], key) do
    [ c ^^^ get_mask(key) | encrypt(cs, Stream.drop(key, 2)) ]
  end 

  def main(argv) do
    key = argv |> List.first |> to_char_list |> Stream.cycle

    IO.read(:line)
    |> to_char_list
    |> encrypt(key)
    |> hex_string_of_ints
    |> IO.write
  end
end
