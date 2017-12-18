data = File.read("data/18.txt").strip

test_a = <<TEST
set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2
TEST

test_b = <<TEST
snd 1
snd 2
snd p
rcv a
rcv b
rcv c
rcv d
TEST

class Interpreter
  def initialize(code, registers: {}, input:, output:)
    @registers = Hash.new(0).merge(registers)
    @input = input
    @output = output
    @code = code.lines
    @pc = 0
    @waiting = false
  end

  attr_reader :waiting

  def run_one
    do_ins(@code[@pc])
    @pc += 1
  end

  def do_ins(code)
    code = code.strip.split(' ')
    ins, *args = code
    send(ins, *args)
  end

  def val(reg_or_imm)
    if reg_or_imm =~ /\A-?[0-9]+\Z/
      reg_or_imm.to_i
    else
      raise unless reg_or_imm =~ /\A[a-z]\Z/
      registers[reg_or_imm]
    end
  end

  attr_reader :registers

  def set(reg, imm)
    registers[reg] = val(imm)
  end

  def add(reg, imm)
    registers[reg] += val(imm)
  end

  def mul(reg, imm)
    registers[reg] *= val(imm)
  end

  def mod(reg, imm)
    registers[reg] %= val(imm)
  end

  def rcv(reg)
    if val = @input.call
      registers[reg] = val
      @waiting = false
    else
      @waiting = true
      @pc -= 1
    end
  end

  def jgz(reg, imm)
    if val(reg) > 0
      @pc += val(imm) - 1
    end
  end

  def snd(imm)
    @output.call(val(imm))
  end
end

def part1(data)
  sound = nil
  interpreter = Interpreter.new(data, input: Proc.new { return sound }, output: ->(v){ sound = v })

  loop { interpreter.run_one }
end

def part2(data)
  sent = 0
  in0 = []
  in1 = []
  i0 = Interpreter.new(data, registers: { 'p' => 0 }, input: -> { in0.shift }, output: ->(v){ in1 << v })
  i1 = Interpreter.new(data, registers: { 'p' => 1 }, input: -> { in1.shift }, output: ->(v){ in0 << v; sent += 1 })

  while !(i0.waiting && i1.waiting)
    i0.run_one
    i1.run_one
  end

  sent
end

raise unless part1(test_a) == 4
p part1(data)

raise unless part2(test_b) == 3
p part2(data)
