day = File.basename(__FILE__, ".rb")
data = File.read("data/#{day}.txt")

test = <<TEST
TEST

def calculate(data)
  data
end

p calculate(test)
#p calculate(data)
