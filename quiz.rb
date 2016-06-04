class Quiz
  attr_accessor :questions, :answers

  # TODO takes a file as input, outputs two files.
  def initialize(file = nil)
    @questions = []
    @answers = []
  end

  def extract_unique(dictionary, word_length)
    uniques = Hash.new(0)
    answers = Hash.new(0) 

    dictionary.each do |word|
      next if word.size < word_length
      word.chars.each_cons(word_length) do |char_group|
        uniques[char_group.join] += 1
        answers[char_group.join] = dictionary.index(word) 
      end
    end

    repeats = uniques.reject{ |v,k|k==1 }.keys

    repeats.each do |r|
      uniques.delete(r)
      answers.delete(r)
    end

    @questions = uniques.keys # TODO write this to file

    answers.values.each do |v|
      @answers << dictionary[v]
    end
  end
end
