  module QuestionsAndAnswers

  require 'pry'
  require 'pry-remote'

  SEQUENCE_LENGTH = 4
  SEQUENCE_REGEX = Regexp.new("(?=([a-z0-9]{#{SEQUENCE_LENGTH}}))")

  def get_words_array(filename)
    return File.readlines(filename).map(&:split).flatten
  end

  def generate_question_and_answer_files(filename)
    words_array = self.get_words_array(filename)
    question_and_answer_values = self.questions_and_answers(words_array)

    question_and_answer_values.each do |question_and_answer_value|
      write_filename = question_and_answer_value[:filename]
      array = question_and_answer_value[:array]

      File.open(write_filename, "w+") do |f|
        f.puts(array)
      end
    end
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
      },
      {
        :filename => "answers",
        :array => answers
      }
    ]
  end

end
