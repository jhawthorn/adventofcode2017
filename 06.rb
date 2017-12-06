DATA = File.read("data/06.txt").split.map(&:to_i)

def calculate(data)
  banks = data
  seen = {}
  iterations = 0

  loop do
    seen[banks] = iterations
    amount = banks.max
    largest_bank = banks.index(amount)
    banks[largest_bank] = 0
    target_bank = largest_bank + 1
    amount.times do
      banks[target_bank % banks.size] += 1
      target_bank += 1
    end
    iterations += 1
    return [iterations, iterations - seen[banks]] if seen[banks]
  end
end

raise unless calculate([0, 2, 7, 0]) == [5,4]
puts calculate(DATA)
