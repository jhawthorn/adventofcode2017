data = "5 1 9 5
7 5 3
2 4 6 8"

data = File.read("data/02.txt")

rows = data.lines.map do |row|
  row.split.map(&:to_i)
end

rows.map! do |row|
  row.max - row.min
end

p rows.sum
