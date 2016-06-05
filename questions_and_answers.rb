module QuestionsAndAnswers

  WORDS_ARRAY = []
  SEQUENCE_LENGTH = 4
  SEQUENCE_REGEX = Regexp.new("(?=([a-z0-9]{#{SEQUENCE_LENGTH}}))")

  # TODO:
  def sequence_in_word?(sequence, word)
    #code
  end

  def sequences_from_word(word)
    return word.scan(SEQUENCE_REGEX)
  end

  # TODO:
  def sequence_in_any_words?(sequence, word_to_ommit)
    #code
  end

  # TODO:
  def generate_questions_and_answers
    #code
  end

  # TODO:
  def write_to_file(filename, array)
    #code
  end

  def question_and_answer_arrays
    questions_intial = []
    answers_initial = []

    words.each do |word|
      sequences = sequences_from_word(word)

      questions_intial.push(sequences)
      answers_initial.push(sequences.size)
    end

    questions_initial.flatten.map do |question|
      if question

      else

      end
    end
  end

end
