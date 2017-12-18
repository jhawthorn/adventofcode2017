def calculate(a, b)
  40_000_000.times.count do
    a = a * 16807 % 2147483647
    b = b * 48271 % 2147483647

    (a & 0xffff) == (b & 0xffff)
  end
end

raise unless calculate(65, 8921) == 588
p calculate(699, 124)
