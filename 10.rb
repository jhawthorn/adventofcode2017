data = File.read("data/10.txt").strip.split(",").map(&:to_i)

def calculate(list_size, lengths)
  list = 0.upto(list_size-1).to_a
  skip = 0
  position = 0

  while !lengths.empty?
    length = lengths.shift

    list[0,length] = list[0,length].reverse

    position += length + skip
    list.rotate!(length + skip)

    skip += 1
  end

  list.rotate!(-position)
  list[0] * list[1]
end

p calculate(5, [3,4,1,5])
p calculate(256, data)
