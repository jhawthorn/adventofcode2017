require 'set'
data = File.read("data/20.txt")

test = <<TEST
p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>
TEST

def calculate(data)
  n = "\s*(-?[0-9]+)"
  particles = []
  data.scan(/^p=<#{n},#{n},#{n}>,\s*v=<#{n},#{n},#{n}>,\s*a=<#{n},#{n},#{n}>$/).each_with_index do |m, i|
    m = m.map(&:to_i).each_slice(3).to_a

    particles << [m, i]
  end

  200.times do
    positions = Set.new
    removals = Set.new
    particles.map do |(p,v,a), i|
      [[v,a], [p,v]].each do |vec1, vec2|
        vec1[0] += vec2[0]
        vec1[1] += vec2[1]
        vec1[2] += vec2[2]
      end
      if positions.include?(p)
        removals.add(p)
      else
        positions.add(p)
      end
      [[p,v,a], i]
    end

    particles.reject! do |(p,v,a), i|
      removals.include?(p)
    end
  end

  particles.count
end

#p calculate(test)
p calculate(data)
