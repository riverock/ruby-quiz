require 'rspec/autorun'
require_relative './solution.rb'
require_relative './test_helper.rb' # test_helper file has all the logics for the tests!

describe GenerateQuestions do

  # Testing Methods
  describe 'test extracting words from file' do
    context 'not valid file' do
      it { should_return_error_message }
    end

    context 'valid file' do
      it { should_extract_words_from_file }
    end
  end

  describe 'test generating sequences' do
    it { should_generate_sequences }
  end

  describe 'test adding questions and answers' do
    it { should_add_questions_and_answers }
  end

  describe 'test generating files' do
    it { should_generate_files }
  end

  # Testing Whole Process
  describe "Test with 'the words.tar.gz' file" do
    before(:all) { @instance = GenerateQuestions.new('words.tar.gz', false, true) }
    it { should_generate_questions_and_answers_files }
    it { should_write_one_word_per_line }
  end

  describe 'Test with just providing an array' do
    before(:all) { @instance = GenerateQuestions.new('', ['arrows', 'carrots', 'give', 'me'], true) }
    it { should_generate_questions_and_answers_files }
    it { should_write_one_word_per_line }
    # Below are testing based on the given examples from the README.
    it { should_match_expected_results }
    it { should_align_questions_and_answers_on_the_same_line }
  end
end