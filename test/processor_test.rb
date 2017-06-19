require_relative "../src/processor"
require "test/unit"

class ProcessorTest < Test::Unit::TestCase
  setup do
    @subject = Processor.new
  end

  def test_initialize
    assert_equal(25143, @subject.words.length)
    assert_equal([], @subject.questions)
    assert_equal([], @subject.answers)
  end

  def test_process
    @subject.instance_variable_set(:@words, ["arrows", "carrots", "give", "me"])
    @subject.process

    assert_equal(["rrow", "rows", "carr", "rrot", "rots", "give"], @subject.questions)
    assert_equal(["arrows", "arrows", "carrots", "carrots", "carrots", "give"], @subject.answers)
  end

  def test_get_valid_parts
    assert_equal(["oran", "rang", "ange"], @subject.get_valid_parts("orange"))
    assert_equal([], @subject.get_valid_parts("let"))
    assert_equal([], @subject.get_valid_parts(""))
  end


  def test_is_question?
    @subject.instance_variable_set(:@words, ["arrows", "carrots", "give", "me"])

    assert(@subject.is_question?("carr"))
    assert(@subject.is_question?("give"))
    assert(@subject.is_question?("rots"))
    assert(@subject.is_question?("rows"))
    assert(@subject.is_question?("rrot"))
    assert(@subject.is_question?("rrow"))
    refute(@subject.is_question?("arro"))
  end

  def test_is_valid_length?
    assert(@subject.is_valid_length?("tester"))
    assert(@subject.is_valid_length?("test"))
    refute(@subject.is_valid_length?("tes"))
    refute(@subject.is_valid_length?(""))
  end

  def test_create_files
    questions_arr = ["question1", "question2", "question3"]
    questions_file_location = "#{File.dirname(__FILE__)}/../solutions/questions"
    @subject.instance_variable_set(:@questions, questions_arr)

    answers_arr = ["answer1", "answer2", "answer3"]
    answers_file_location = "#{File.dirname(__FILE__)}/../solutions/answers"
    @subject.instance_variable_set(:@answers, answers_arr)

    @subject.create_files

    questions_file_arr = File.readlines(questions_file_location).map { |word| word.strip }
    answers_file_arr = File.readlines(answers_file_location).map { |word| word.strip }

    assert_equal(questions_arr, questions_file_arr)
    assert_equal(answers_arr, answers_file_arr)

    # cleanup
    File.delete(questions_file_location)
    File.delete(answers_file_location)
  end

  def test_create_file
    filename = "test"
    data = ["test1", "test2", "test3", "test4"]
    file_location = "#{File.dirname(__FILE__)}/../solutions/#{filename}"

    @subject.create_file(filename, data)

    file_arr = File.readlines(file_location).map { |word| word.strip }

    assert_equal(data, file_arr)

    # cleanup
    File.delete(file_location)
  end
end
