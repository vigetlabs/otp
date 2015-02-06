module Utility

  export hex_to_decimal, is_hex_string, next_index

  hex_to_decimal(h) = int(hex2bytes(convert(ASCIIString, h))[1])
  is_hex_string(s)  = ismatch(r"^[0-9a-f]+$"i, s)
  next_index(s, i)  = ((i + 1) > endof(s)) ? 1 : i + 1

end