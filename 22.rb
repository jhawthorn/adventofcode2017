data = File.read("data/22.txt")

test = <<TEST
..#
#..
...
TEST

NODE_DISPLAY = {
  clean: ".",
  weakened: "W",
  infected: "#",
  flagged: "F",
}

def print_map(map, cy=nil, cx=nil)
  (map.keys.map(&:first).min-1).upto(map.keys.map(&:first).max+1) do |y|
    (map.keys.map(&:last).min-1).upto(map.keys.map(&:last).max+1) do |x|
      print NODE_DISPLAY[map[[y,x]]]
      if y == cy && x == cx
        print "]"
      elsif y == cy && x+1 == cx
        print "["
      else
        print " "
      end
    end
    puts
  end
end

def calculate(rules, data, bursts=70)
  data = data.lines.to_a.map(&:strip)

  # negative indexes stored at end of Array
  map = Array.new(1000) { Array.new(1000, :clean) }

  data.each_with_index do |r, y|
    r.chars.each_with_index do |c, x|
      map[y][x] = :infected if (c == "#")
    end
  end

  direction_map = rules[:direction]
  state_map = rules[:state]

  directions = [[-1,0], [0,1], [1,0], [0,-1]]
  direction = 0
  y = data.count/2
  x = data[0].length/2
  infected = 0

  bursts.times do
    state = map[y][x]

    direction += direction_map[state]
    state = state_map[state]
    infected += 1 if state == :infected
    map[y][x] = state

    dy, dx = directions[direction % 4]
    y += dy
    x += dx
  end

  infected
end

PART1 = {
  state: {
    clean: :infected,
    infected: :clean
  },
  direction: {
    clean: -1,
    infected: 1
  }
}

PART2 = {
  state: {
    clean: :weakened,
    weakened: :infected,
    infected: :flagged,
    flagged: :clean
  },
  direction: {
    clean: -1,
    weakened: 0,
    infected: 1,
    flagged: 2
  }
}

raise unless calculate(PART1, test, 7) == 5
raise unless calculate(PART1, test, 70) == 41
raise unless calculate(PART1, test, 10000) == 5587
p calculate(PART1, data, 10000)

raise unless calculate(PART2, test, 100) == 26
raise unless calculate(PART2, test, 10000000) == 2511944
p calculate(PART2, data, 10000000)
