require 'pry'
require 'byebug'
a = b = c = d = e = f = g = h = 0
a = 1
b = 67
c = b
#jmp 2 if a != 0
#jmp 5
b *= 100
b += 100000
c = b
c += 17000
loop do
  f = 1
  d = 2
  loop do
    e = 2  # loop do
    loop do
      g = d   # loop do
      g *= e
      g -= b
      f = 0 if g == 0
      e += 1
      g = e
      g -= b
      break if g == 0
    end
    d += 1
    g = d
    g -= b
    break if g == 0
  end
  h -= 1 if f == 0
  g = b
  g -= c
  if g == 0
    binding.pry
  end
  b += 17
end
