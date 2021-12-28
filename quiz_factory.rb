# The module which generates a quiz
module QuizFactory
  def self.from_file(filename, output)
    data_file = File.open(filename, 'r')

    return nile if data_file.nil?

    from_data(data_file.read, output)
    data_file.close
  end

  def self.from_data(raw_data, output)
    enough_long_words = raw_data.lines(chomp: true).delete_if { |line| line.length < 4 }
    temp_quiz = {}

    enough_long_words.each do |word|
      (0..word.length - 4).map { |i| word[i, 4] }.each do |question|
        temp_quiz[question] = [] unless temp_quiz.key? question
        temp_quiz[question] << word
      end
    end

    temp_quiz.each { |key, value| output.store(key, value.first) if value.length == 1 }

    questions_file = File.open('questions', 'w')
    File.write(questions_file, output.keys.join("\n"))
    questions_file.close

    answers_file = File.open('answers', 'w')
    File.write(answers_file, output.values.join("\n"))
    answers_file.close
  end
end
