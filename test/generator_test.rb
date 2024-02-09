require 'test/unit'
require './generator'

class GeneratorTest < Test::Unit::TestCase

  def test_questions_and_answers_are_extracted
    file_path = "test/support/words.txt"
    generator = Generator.new(file_path)
    generator.generate_files

    questions = []
    File.readlines("questions.txt", chomp: true).each do |line|
      questions << line
    end

    answers = []
    File.readlines("questions.txt", chomp: true).each do |line|
      answers << line
    end

    assert questions.length == 33
    assert answers.length == 33
  end
end

