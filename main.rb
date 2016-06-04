require_relative 'quiz'

word_length = 4
dictionary = Array.new

f = File.open(ARGV[0])

f.each_line do |line|
  dictionary << line.to_s.strip # TODO Maybe strip out apostrophes? 
 end

q = Quiz.new

q.extract_unique(dictionary, word_length)
