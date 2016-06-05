module QuestionsAndAnswers

  WORDS_ARRAY = []
  SEQUENCE_LENGTH = 4
  SEQUENCE_REGEX = Regexp.new("(?=([a-z0-9]{#{SEQUENCE_LENGTH}}))")

  def sequence_in_word?(sequence, word)
    #code
  end

  def sequences_from_word(word)
    return word.scan(SEQUENCE_REGEX)
  end

  def sequence_in_any_words?(sequence, word_to_ommit)
    #code
  end

  def generate_questions_and_answers
    #code
  end

  def write_to_file(filename, array)
    #code
  end

end
