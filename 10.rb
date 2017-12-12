data = File.read("data/10.txt").strip

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

def part1(list_size, input)
  list = hash_round(list_size, input)
  list[0] * list[1]
end

raise unless part1(5, [3,4,1,5]) == 12
part1_data = data.split(',').map(&:to_i)
p part1(256, part1_data)

def part2(input)
  lengths = input.chars.map(&:ord) + [17, 31, 73, 47, 23]
  list = hash_round(256, lengths, rounds: 64)

  list.each_slice(16).map{|x| "%.2x" % x.inject(:^) }.join
end

#p part2_data
raise unless part2("") == "a2582a3a0e66e6e86e3812dcb672a272"
raise unless part2("AoC 2017")
p part2("1,2,3")
p part2("1,2,4")

p part2(data)
