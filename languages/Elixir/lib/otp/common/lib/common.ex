#!/usr/bin/env elixir

use Bitwise

defmodule OTP.Common do
  def key(argv) do
    argv |> List.first |> to_char_list |> Stream.cycle
  end

  def int_of_hex_chars([c1, c2]) do
    String.to_integer << c1, c2 >>, 16
  end

  def get_mask(key) do
    Enum.take(key, 2) |> int_of_hex_chars
  end

  def hex_string_of_ints(ints) do
    Enum.map ints, &(&1 |> Integer.to_string(16) |> String.downcase)
  end
end
