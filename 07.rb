TEST = <<TEST
pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)
TEST

DATA = File.read("data/07.txt")

def parse(text)
  text.scan(/^([a-z]+) \(([0-9]+)\)(?: -> )?(.*)$/).map do |name, weight, children|
    [name, weight.to_i, children.split(", ")]
  end
end

def verify(p)
  weights = p[2].map { |w| w[3] }

  r = p[2].map(&method(:verify)).compact[0]
  return r if r

  if weights.uniq.size > 1
    desired_weight = weights.group_by{|x| x}.max_by{|k,v|v.size}[0]
    p[2].each do |child|
      next if child[3] == desired_weight
      return child[1] + (desired_weight - child[3])
    end
  end

  nil
end

def add_weights(n)
  n[2].each(&method(:add_weights))

  n << n[1] + n[2].sum{|c| c[3] }
end

def calculate(data)
  root = Hash[data.map{ |n| [n[0], n] }]

  data.each do |p|
    p[2].map!(&root.method(:delete))
  end

  root = root.values[0]

  add_weights(root)

  [root[0], verify(root)]
end

raise unless calculate(parse(TEST)) == ["tknk", 60]
p calculate(parse(DATA))
