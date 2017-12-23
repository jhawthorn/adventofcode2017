data = File.read("data/23.txt")

class Interpreter
  def initialize(code, registers: {})
    @registers = Hash.new(0).merge(registers)
    @code = code.lines.map(&:strip).reject(&:empty?)
    @pc = 0
    @muls = 0
  end

  attr_reader :muls

  def run
    while run_one
    end
  end

  def run_one
    return false if @pc >= @code.length
    do_ins(@code[@pc])
    @pc += 1
    true
  end

  def do_ins(code)
    code = code.strip.gsub(/#.*$/, '').split(' ')
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

  def sub(reg, imm)
    registers[reg] -= val(imm)
  end

  def mul(reg, imm)
    @muls += 1
    registers[reg] *= val(imm)
  end

  def jnz(reg, imm)
    if val(reg) != 0
      @pc += val(imm) - 1
    end
  end
end


def calculate(data)
  interpreter = Interpreter.new(data, registers: {'a' => 0})
  interpreter.run
  interpreter.muls
end

p calculate(data)
