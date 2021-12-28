# frozen_string_literal: true

class GenerateQuestionsAnswers
  def initialize(words_file, write_to_file = true)
    @words_file = words_file
    @write_to_file = write_to_file
  end

  def call
    qna = {}

    File.foreach(words_file) do |line|
      word = line.strip
      next if word.length < Q_LEN

      (word.length - Q_LEN + 1).times do |i|
        candidate = word[i...(i + 4)]
        if qna[candidate]
          qna.delete candidate
        else
          qna[candidate] = word
        end
      end
    end

    qna = qna.sort_by { |k, _v| k }.to_h

    if write_to_file?
      questions_file = File.join(File.dirname(words_file), "questions")
      File.write(questions_file, qna.keys.join("\n"))
      answers_file = File.join(File.dirname(words_file), "answers")
      File.write(answers_file, qna.values.join("\n"))
    else
      [qna.keys, qna.values]
    end
  end

  private

  attr_reader :words_file
  attr_reader :write_to_file

  alias_method :write_to_file?, :write_to_file

  Q_LEN = 4
end
