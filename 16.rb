data = File.read("data/16.txt").strip

test = <<TEST
s1,x3/4,pe/b
TEST

def compile(data, programs)
  moves = 0.upto(programs.length - 1).to_a
  substitutions = Hash[programs.chars.map{|x| [x,x] }]

  data.split(',').each do |move|
    args = move[1,move.length].strip.split('/')
    if move[0] == 's'
      moves.rotate!(-args[0].to_i)
    elsif move[0] == 'x'
      moves[args[0].to_i], moves[args[1].to_i] = moves[args[1].to_i], moves[args[0].to_i]
    elsif move[0] == 'p'
      substitutions.each do |k,v|
        substitutions[k] = args[1] if v == args[0]
        substitutions[k] = args[0] if v == args[1]
      end
    end
  end

  [moves, substitutions]
end

def calculate(data, programs, rounds=1)
  m, s = compile(data, programs)
  while rounds > 0
    if (rounds & 1) == 1
      # Apply the current 2**n dance
      programs = m.map { |i| s[programs[i]] }
    end

    # Double the number of dances each application will perform
    m = m.map { |i| m[i] }
    s = s.transform_values { |v| s[v] }

    rounds >>= 1
  end
  programs.join
end

raise unless calculate(test, "abcde") == "baedc"
puts calculate(data, "abcdefghijklmnop", 1)

raise unless calculate(test, "abcde", 2) == "ceadb"
puts calculate(data, "abcdefghijklmnop", 1_000_000_000)
