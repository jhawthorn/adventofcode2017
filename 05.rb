
data = File.read("data/05.txt")

data = data.lines.map(&:to_i)

pc = 0
steps = 0
loop do
  break if pc < 0 || pc >= data.length
  p pc
  nextpc = pc + data[pc]
  data[pc] += 1
  pc = nextpc
  steps += 1
end

p steps