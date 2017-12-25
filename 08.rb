data = File.read("data/08.txt")

after_each = <<RUBY
max = [max, vars.values.max || 0].max
RUBY

vars = Hash.new(0)
max = 0
data = data.gsub('dec', '-=').gsub('inc', '+=').gsub(/(^| if )([a-z]+)/, "\\1vars['\\2']")
data = data.lines.map{|x| x + "#{after_each}\n" }.join
#puts data
eval(data)
p vars.values.max
p max
