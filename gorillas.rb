def print_to_screen(x,y,str)
  x = (x > 0) ? x : 1
  y = (y > 0) ? y : 1

  buffer = VIM::Buffer.current
  buffer[x][y, str.length] = str
end

#print_to_screen(5,15, "hello gorillas!")
VIM::Buffer.current.append(0, "hello gorillas!")
