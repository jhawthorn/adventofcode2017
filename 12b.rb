require 'set'

data = File.read("data/12.txt").strip

def calculate(data)
  unvisited = Set.new
  connections = Hash.new{|h,k| h[k] = Set.new}
  data = data.lines.each do |line|
    node, children = line.strip.split(' <-> ', 2)
    node = node.to_i
    children = children.split(', ').map(&:to_i)

    unvisited.add(node)
    children.each do |child|
      unvisited.add(child)
      connections[node] << child
      connections[child] << node
    end
    connections[node]
  end

  count = 0
  while !unvisited.empty?
    visited = Set.new

    queue = [unvisited.first]
    while node = queue.shift
      next if visited.include?(node)
      visited.add(node)
      queue.concat(connections[node].to_a)
    end

    count += 1

    unvisited -= visited
  end

  count
end

test = "
0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5
".strip

p calculate(test)
p calculate(data)
