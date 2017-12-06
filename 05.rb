
data = File.read("data/05.txt")

data = data.lines.map(&:to_i)

pc = 0
steps = 0
loop do
  break if pc < 0 || pc >= data.length
  offset = data[pc]
  if offset >= 3
    data[pc] -= 1
  else
    data[pc] += 1
  end
  pc += offset
  steps += 1
end

p steps
