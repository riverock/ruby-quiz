require 'minitest/autorun'
require_relative '../engine'
require_relative '../extenders'

class TestHash < MiniTest::Unit::TestCase

  def setup
    @test = Engine.new 'test/files/list'
  end

  def test_generate_to_questions_file
    questions_file = @test.process.to_questions_file
    expected = Engine.convert_file_to_array(questions_file)
    assert_equal %w{ carr give rots rows rrot rrow }.sort, expected.sort
  end

  def test_generate_to_answers_file
    answers_file = @test.process.to_answers_file
    expected = Engine.convert_file_to_array(answers_file)
    assert_equal %w{ arrows arrows carrots carrots carrots give }.sort, expected.sort
  end

end

