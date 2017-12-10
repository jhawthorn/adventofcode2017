def count_groups(s)
  s.gsub!(/!./, '')
  s.gsub!(/<[^>]*>/, '')
  s.gsub!(/[^{}]/, '')

  score = 0
  total = 0
  s.chars.each do |c|
    score += 1 if c == '{'
    if c == '}'
      total += score
      score -= 1
    end
  end
  total
end

p count_groups(File.read("data/09.txt"))
