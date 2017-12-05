
data = File.read("data/05.txt")

data = data.lines.map(&:to_i)

pc = 0
steps = 0
loop do
  break if pc < 0 || pc >= data.length
  oldpc = pc
  offset = data[pc]
  nextpc = pc + offset
  if offset >= 3
    data[pc] -= 1
  else
    data[pc] += 1
  end
  pc = nextpc
  steps += 1
end

p steps
