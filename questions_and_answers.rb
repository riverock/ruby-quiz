module QuestionsAndAnswers

  SEQUENCE_LENGTH = 4
  SEQUENCE_REGEX = Regexp.new("(?=([a-z0-9]{#{SEQUENCE_LENGTH}}))")

  def get_words_array(filename)
    #code
  end

  def generate_question_and_answer_files()
    words_array = self.get_words_array("filename")
    question_and_answer_values = self.questions_and_answers(words_array)
  end

  def sequences_from_word(word)
    return word.scan(SEQUENCE_REGEX)
  end

  def questions_and_answers(words_array)
    sequences_and_words = words_array.map do |word|
      sequences = self.sequences_from_word(word)

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

    return [
      {
        :filename => "questions",
        :array => questions
      }
      {
        :filename => "answers",
        :array => answers
      }
    ]
  end

  def write_to_file(filename, array)
    #code
  end

end
