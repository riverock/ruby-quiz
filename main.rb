require_relative 'quiz'

dictionary = Array.new

f = File.open(ARGV[0]) # TODO Build in support for .gz
word_length = ARGV.length > 1 ? ARGV[1].to_i : 4 # Checks for an extra ARGV and uses it as wordlength. Else 4 for default.

f.each_line do |line|
  dictionary << line.to_s.strip # TODO Maybe strip out apostrophes? Seems like a domain/data issue to me.
end

q = Quiz.new
q.extract_unique(dictionary, word_length)
