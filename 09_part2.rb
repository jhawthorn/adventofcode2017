def count_garbage(s)
  s.gsub!(/!./, '')

  s.length - s.gsub(/<[^>]*>/, '<>').length
end

p count_garbage(File.read("data/09.txt"))
