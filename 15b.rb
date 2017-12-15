def calculate(a, b)
  as = Enumerator.new do |y|
    loop do
      a = a * 16807 % 2147483647
      y << a if a % 4 == 0
    end
  end

  bs = Enumerator.new do |y|
    loop do
      b = b * 48271 % 2147483647
      y << b if b % 8 == 0
    end
  end

  5_000_000.times.count do
    a = as.next
    b = bs.next

    (a & 0xffff) == (b & 0xffff)
  end
end

raise unless calculate(65, 8921) == 309
p calculate(699, 124)
