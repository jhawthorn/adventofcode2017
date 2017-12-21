require 'set'
require 'prime'

data = File.read("data/21.txt").strip

initial = <<TEST
.#.
..#
###
TEST

test = <<TEST
../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#
TEST

def split_by(image, n)
  image.each_slice(n).flat_map do |rows|
    rows = rows.map do |row|
      (0...row.length).step(n).map do |i|
        row[i, n]
      end
    end
    rows.shift.zip(*rows).map{|x| x.join("/") }
  end
end

def mirror(original, n)
  original = original.split("/").map(&:chars)
  original.transpose.map(&:join).join("/")
end

def rotations(original)
  n = original.index("/")
  [original, mirror(original, n)].flat_map do |s1|
    [s1, s1.split("/").reverse.join("/")].flat_map do |s2|
      [s2, s2.split("/").map(&:reverse).join("/")]
    end
  end.uniq
end

def rejoin(squares, n)
  squares.each_slice(n).flat_map do |ys|
    ys = ys.map{|x| x.split("/") }
    y1 = ys.shift
    y1.zip(*ys).map do |line|
      line.join
    end
  end
end

def round(image, rules)
  n = nil
  if image.size % 2 == 0
    n = 2
  elsif image.size % 3 == 0
    n = 3
  else
    raise
  end

  squares = split_by(image, n)

  squares =
    squares.map do |square|
      rules.fetch(square)
    end

  rejoin(squares, image.size/n)
end

def calculate(image, data, rounds)
  rules = Hash[data.lines.map{|x| x.strip.split(' => ') }]
  rules.update(Hash[
    rules.flat_map do |k,v|
      rotations(k).map do |r|
        [r, v]
      end
    end
  ])
  image = image.lines.map(&:strip)

  rounds.times do |r|
    image = round(image, rules)
  end

  image.join.count('#')
end

raise unless calculate(initial, test, 2) == 12
p calculate(initial, data, 5)
p calculate(initial, data, 18)
