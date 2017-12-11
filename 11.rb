data = File.read("data/11.txt").strip

def distance(x,y)
    together = [x.abs, y.abs].min

    x -= (x/x.abs) * together unless x.zero?
    y -= (y/y.abs) * together unless y.zero?

    together + x.abs + (y.abs / 2)
end

def calculate(data)
  data = data.split(",")

  furthest = 0
  x = 0
  y = 0
  data.each do |d|
    case d
    when 'nw'
      x -= 1
      y += 1
    when 'ne'
      x += 1
      y += 1
    when 'sw'
      x -= 1
      y -= 1
    when 'se'
      x += 1
      y -= 1
    when 's'
      y -= 2
    when 'n'
      y += 2
    else
      raise d
    end

    furthest = [distance(x,y), furthest].max
  end

  [distance(x,y), furthest]
end

p calculate("ne,ne,ne")
p calculate("ne,ne,sw,sw")
p calculate("ne,ne,s,s")
p calculate("se,sw,se,sw,sw")
p calculate(data)

