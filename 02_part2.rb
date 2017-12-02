data = "5 9 2 8
9 4 7 3
3 8 6 5"

data = File.read("data/02.txt")

rows = data.lines.map do |row|
  row.split.map(&:to_i).sort.reverse
end

rows.map! do |row|
  row = row.dup
  while numerator = row.shift
    result = row.detect {|denominator| numerator % denominator == 0 }
    next unless result
    break numerator / result
  end
end

p rows.sum
