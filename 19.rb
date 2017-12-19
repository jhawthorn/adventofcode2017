data = File.read("data/19.txt")

test = <<TEST
     |          
     |  +--+    
     A  |  C    
 F---|----E|--+ 
     |  |  |  D 
     +B-+  +--+ 

TEST

def calculate(data)
  grid = data.chomp.lines
  w = data.index("\n")
  grid = [" "*w, *grid, " "*w]
  dx, dy = 0, 1
  py, px = 1, grid[1].index('|')
  letters = []
  steps = 1

  loop do
    py, px = py + dy, px + dx

    c = grid[py][px]

    case c
    when ' '
      return [steps, letters.join]
    when '+'
      dy, dx =
        [[0,1], [0,-1], [1,0], [-1,0]].detect do |ndy, ndx|
          ndy != dy && ndx != dx && grid[py + ndy][px + ndx] != ' '
        end
    when /[a-z]/i
      letters << c
    end

    steps += 1
  end
end

p calculate(test)
p calculate(data)
