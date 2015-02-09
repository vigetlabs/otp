function next_key_byte(key, start_index)
  byte, index = ("", start_index)

  for i in [1, 2]
    byte *= string(key[index])
    index = next_index(key, index)
  end

  (hex_to_decimal(byte), index)
end
