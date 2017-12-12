data = "5 9 2 8
9 4 7 3
3 8 6 5"

data = File.read("data/02.txt")

rows = data.lines.map do |row|
  row.split.map(&:to_i).sort.reverse
end

rows.map! do |row|
  row.combination(2).each do |numerator, denominator|
    break numerator / denominator if numerator % denominator == 0
  end
end

p rows.sum
