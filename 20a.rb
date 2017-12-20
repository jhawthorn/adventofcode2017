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

  # This doesn't work in general, but our input is generous and only has one
  # particle with minimal acceleration.
  #
  # Actually, it has a particle with an acceleration of 0, so writing code for
  # this is pretty pointless anyways.
  particles.min_by{|(p,v,a), i| a.sum(&:abs) }.last
end

raise unless calculate(test) == 0
p calculate(data)
