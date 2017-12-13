require 'set'
require 'prime'

data = File.read("data/13.txt").strip

test = <<TEST
0: 3
1: 2
4: 4
6: 4
TEST

def parse(data)
  data.lines.map do |x|
    range, depth = x.split(": ").map(&:to_i)
    [range, depth * 2 - 2]
  end
end

def calculate(data, delay)
  data.any? do |range, depth|
    (range + delay) % depth == 0
  end
end

def part2(data)
  i = 0
  while calculate(data, i)
    i += 1
  end
  i
end

p part2(parse(test))
p part2(parse(data))
