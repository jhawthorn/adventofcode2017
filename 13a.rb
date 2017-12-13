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
    x.split(": ").map(&:to_i)
  end
end

def calculate(data)
  data.sum do |range, depth|
    if range % (depth * 2 - 2) == 0
      range * depth
    else
      0
    end
  end
end

p calculate(parse(test))
p calculate(parse(data))
