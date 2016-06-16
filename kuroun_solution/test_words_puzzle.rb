require_relative "words_puzzle"
require "test/unit"

class TestWordsPuzzle < Test::Unit::TestCase
  def setup
    @wp = WordsPuzzle.new(4)
    @wp.read_file "words"
    @word = @wp.get_random_word
    @seq_word = @wp.get_sequence_word(@word)
  end
  
  #make sure that dictionary contains no word which length less than the sequence word length
  def test_read_file
    @wp.dictionary.each do |k,v|
      assert_operator k.length,:>=, @wp.num
    end
  end
  
  #make sure that random word exists in dictionary
  def test_get_random_word
    assert(@wp.dictionary.key?@word)
  end
  
  #make sure sequence word is contain in the word and its lenght is equal to number assigned
  def test_get_sequence_word
    assert(@word.include?@seq_word)
    assert_equal(@seq_word.length,@wp.num)
  end
  
  #expect to return false when sequence word exists in dictionary more than one time
  def test_add_sequence_word
     word = "slogan"
     seq = "slog"
     @wp.dictionary[word] = nil
     add = @wp.add_random_sequence(word,seq)
     assert_equal(add, false)
  end
  
  #test whether the file 'questions' and 'answers' exist
  def test_write_questions_answers
    @wp.write_questions_answers
    questions = File.file?('questions')
    answers = File.file?('answers')
    assert(questions && answers)
  end
  
  #test clear function
  def test_clear
    count = 0
    while(true) do
      word = @wp.get_random_word
      sequence = @wp.get_sequence_word(word)
      process = @wp.add_random_sequence(word, sequence)
      count += 1 if(process==true)
      break if(count==10)  
    end
    #expect false if dictionary and questions_answers is not empty
    assert_equal(@wp.dictionary.empty?, false)
    assert_equal(@wp.questions_answers.empty?, false)
    
    @wp.clear
    #expect true after clear
    assert_equal(@wp.dictionary.empty?, true)
    assert_equal(@wp.questions_answers.empty?, true)
  end
end