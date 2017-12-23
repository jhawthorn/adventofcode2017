require 'pry'
require 'byebug'
require 'prime'
a = b = c = d = e = f = h = 0
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
  f = 0 unless b.prime?
  h += 1 if f == 0
  if b - c == 0
    puts h
    exit 0
  end
  b += 17
end
