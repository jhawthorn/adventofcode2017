def calculate(a, b)
  5_000_000.times.count do
    a = a * 16807 % 2147483647
    a = a * 16807 % 2147483647 while a % 4 != 0
    b = b * 48271 % 2147483647
    b = b * 48271 % 2147483647 while b % 8 != 0

    (a & 0xffff) == (b & 0xffff)
  end
end

raise unless calculate(65, 8921) == 309
p calculate(699, 124)
