require_relative 'ruby_quiz'
require 'test/unit'
 
class TestRubyQuiz < Test::Unit::TestCase
 
  def setup
    ruby_quiz = RubyQuiz.new('words')
    ruby_quiz.define_questions
    ruby_quiz.find_answers
  end


  def test_questions
    count = 0
    question = ''

    words_file = File.open('questions', 'r') 
    words_file.each_line do |word, index|
      count = count + 1

      question = word.strip if count == 1
    end
    words_file.close

    assert_equal(10082, count)
    assert_equal('10th', question)
  end


  def test_answers
    count = 0
    answer = ''

    words_file = File.open('answers', 'r') 
    words_file.each_line do |word, index|
      count = count + 1

      answer = word.strip if count == 1
    end
    words_file.close

    assert_equal(10082, count)
    assert_equal('10th', answer)
  end
end
