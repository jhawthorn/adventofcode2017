eval(File.read('data/04.rb'))

phrases =
  DATA.lines.map do |line|
    line.split
  end.select do |phrase|
    phrase.uniq == phrase
  end

p phrases.count

