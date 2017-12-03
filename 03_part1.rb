def assert(bool)
  raise unless bool
end

class Spiral
  def each_diagonal
    return enum_for(:each_diagonal) unless block_given?

    n = 1
    width = 1

    yield n

    loop do
      width += 2

      4.times do
        n += (width - 1)
        yield n, width
      end
    end
  end
end

def distance(n)
  lastd = 0
  w = Spiral.new.each_diagonal do |d, width|
    if n < d
      midpoint = (d + lastd) / 2
      p [n - midpoint, width/2]
      break (n - midpoint).abs + (width/2)
    end
    lastd = d
  end
  w
end

#assert distance(1) == 0
assert distance(12) == 3
assert distance(23) == 2
assert distance(1024) == 31

p distance(312051)

