function read_from(stream)
  data = ""
  while !eof(stream)
    data *= string(read(stream, Char))
  end
  data
end
