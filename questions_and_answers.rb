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

  def questions_and_answers
    sequences_and_words = words.map do |word|
      sequences = sequences_from_word(word)

      sequences.map do |sequence|
        {
          :sequence => sequence,
          :word => word
        }
      end
    end

    uniq_sequences_and_words = sequences_and_words.flatten.uniq do |sequence_and_word|
      sequence_and_word[:sequence]
    end

    questions = uniq_sequences_and_words.map { |x| x[:sequence] }
    answers = uniq_sequences_and_words.map { |x| x[:word] }

    return [questions, answers]
  end

end
