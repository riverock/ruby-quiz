#-----------------------------------------------------------------
# I understand that this is a bit of a monster.
# Hence using a class to encapsulate it.
#-----------------------------------------------------------------
class KeyGen < Struct.new(:word, :substring_len)
  def each(&block)
    ((substring_len-word.length)-1).upto(-1) { |n| block.call(word[(word.length+ n - (substring_len-1))..n]) }
  end
end

words = File.readlines('words')

questions = {}
words.each do |word|
  KeyGen.new(word.chomp, 4).each do |key|
    if questions[key]
      questions[key] = nil
    else
      questions[key] = word
    end
  end
end

def to_f(questions)
  qfile = File.open("questions", "w+")
  afile = File.open("answers", "w+")
  questions.each do |k, v|
    if v
      qfile.puts k
      afile.puts v
    end
  end
  qfile.close
  afile.close
end

to_f questions.sort_by { |q, a| q }

