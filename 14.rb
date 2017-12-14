require 'set'
require 'prime'

def hash_round(list_size, original_lengths, rounds: 1)
  list = 0.upto(list_size-1).to_a
  skip = 0
  position = 0

  rounds.times do
    lengths = original_lengths.dup
    while !lengths.empty?
      length = lengths.shift

      list[0,length] = list[0,length].reverse

      position += length + skip
      list.rotate!(length + skip)

      skip += 1
    end
  end

  list.rotate!(-position)

  list
end

def knothash(input)
  lengths = input.chars.map(&:ord) + [17, 31, 73, 47, 23]
  list = hash_round(256, lengths, rounds: 64)

  list.each_slice(16).map{|x| "%.8b" % x.inject(:^) }.join
end

def dfs(grid, row, col)
  return if row < 0 || col < 0 || col > 127 || row > 127
  return if grid[row][col] != '#'
  grid[row][col] = '.'
  dfs(grid, row, col+1)
  dfs(grid, row, col-1)
  dfs(grid, row+1, col)
  dfs(grid, row-1, col)
end

def calculate(data)
  grid =
    0.upto(127).map do |n|
      knothash(data + "-#{n}").gsub('1', '#').gsub('0', '.')
    end

  total_squares = grid.join.count('#')

  groups = 0
  grid.each_with_index do |row, y|
    while idx = row.index('#')
      dfs(grid, y, idx)
      groups += 1
    end
  end

  [total_squares, groups]
end

p calculate("flqrgnkx")
p calculate("xlqgujun")
