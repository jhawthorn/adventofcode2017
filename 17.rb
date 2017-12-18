def part1(skip)
  buffer = [0]
  position = 0
  1.upto(2017) do |v|
    position += skip
    position %= buffer.length
    buffer.insert(position+1, v)
    position += 1
  end
  buffer[(position + 1) % buffer.length]
end

def part2(skip)
  position = 0
  last = nil
  1.upto(50000000) do |v|
    position += skip
    position %= v
    last = v if position == 0
    position += 1
  end
  last
end

p part1(369)
p part2(369)
