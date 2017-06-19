class Processor
  attr_reader :words, :questions, :answers

  def initialize
    @words = File.readlines("#{File.dirname(__FILE__)}/../data/words").map { |word| word.strip }
    @questions = []
    @answers = []
  end

  def process
    words.each do |word|
      get_valid_parts(word).each do |part|
        if is_question?(part)
          questions << part
          answers << word
        end
      end
    end

    create_files
  end

  def get_valid_parts(word)
    parts = [].tap do |arr|
      (0..(word.length - 3)).each do |index|
        part = word[index..index+3]
        arr << part if is_valid_length?(part)
      end
    end
  end

  def is_question?(part)
    return false if questions.include?(part)
    occurrences = 0

    words.each do |word|
      occurrences += 1 if word.include?(part)
      return false if occurrences > 1
    end

    true
  end

  def is_valid_length?(part)
    part.length >= 4
  end

  def create_files
    create_file("questions", questions)
    create_file("answers", answers)
  end

  def create_file(filename, data)
    File.open("#{File.dirname(__FILE__)}/../solutions/#{filename}", "w") { |file| file.write data.join("\n")}
  end
end
