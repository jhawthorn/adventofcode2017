require 'set'
data = File.read("data/24.txt")

test = <<TEST
0/2
2/2
2/3
3/4
3/5
0/1
10/1
9/10
TEST

def build_from(components:, used: {}.compare_by_identity, start: 0, &block)
  components.fetch(start){ [] }.reject do |component|
    used.key?(component)
  end.map do |component|
    to = component[0] == start ? component[1] : component[0]
    new_used = used
    new_used[component] = true
    r = build_from(components: components, used: new_used, start: to, &block) << to << start
    new_used.delete(component)
    r
  end.max_by(&block) || []
end

def parse(data)
  data = data.lines.map{|l| l.strip.split('/').map(&:to_i) }
  data = data.map(&:sort).sort
  p data.select{|a,b| a == b }
  data.group_by(&:first).merge(data.group_by(&:last)){|k, a, b| a + b }
end

def part1(components)
  build_from(components: components, &:sum).sum
end

def part2(components)
  build_from(components: components) { |x| [x.length, x.sum] }.sum
end

raise unless part1(parse(test)) == 31
p part1(parse(data))

raise unless part2(parse(test)) == 19
p part2(parse(data))
