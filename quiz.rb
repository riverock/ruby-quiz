class Quiz
  attr_accessor :questions, :answers

  # TODO takes a file as input, outputs two files.
  def initialize()
    @questions = []
    @answers = []
  end

  def extract_unique(dictionary, word_length)
    uniques = Hash.new(0)

    dictionary.each do |word|
      next if word.size < word_length
      word.chars.each_cons(word_length) do |char_group|
        uniques[char_group.join] += 1 
      end
    end

    # ultimately I want a hash, uniques{}, that has keys of uniq char groups and values are array index of
    # the original word from dictionary[]
    #
    # is it maybe more efficient to map dictionary to a hash and do a merge of some sort?

    @questions = uniques.select{ |k,v| v == 1 }.keys # TODO write this to file
    @answers = uniques.select{ |k,v| v == 1 }.values # TODO Map unique groups to original word in dictionary

  end 
end
