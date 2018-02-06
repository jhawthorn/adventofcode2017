def calculate(a, b, n=40_000_000)
  i = 0; c = 0
  while i < n
    a = a * 16807 % 2147483647
    b = b * 48271 % 2147483647

    c += 1 if (a & 0xffff) == (b & 0xffff)

    i += 1
  end
  c
end

5.times { calculate(0,0,1) }

raise unless calculate(65, 8921) == 588
p calculate(699, 124)
