require 'set'
require 'yaml'
require 'pp'

test = YAML.load(<<-TEST)
initial: A
checksum: 6
transitions:
  A:
    0:
      - 1
      - 1
      - B
    1:
      - 0
      - -1
      - B
  B:
    0:
      - 1
      - -1
      - A
    1:
      - 1
      - 1
      - A
TEST

data = YAML.load(File.read("data/25.txt"))

def calculate(data)
	state = data['initial']
	checksum = data['checksum']
	transitions = data['transitions']

	tape = Array.new(10000, 0)
  pos = 0

  checksum.times do
    val = tape[pos]
    new_val, move, new_state = transitions[state][val]
    tape[pos] = new_val
    pos += move
    state = new_state
  end
  tape.count(1)
end

raise unless calculate(test) == 3
p calculate(data)

