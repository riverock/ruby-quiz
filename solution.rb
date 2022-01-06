require 'rubygems/package'

class Dictionary
  attr_accessor :dictionary

  def initialize(dictionary)
    self.dictionary = dictionary
  end

  # yields every unique sequence of four letters that appears in exactly one of the dictionary entries (and the entry that the sequence was found in)
  def each_unique_key_pair(&block)
    lookup_table.each do |question, answers|
      next unless answers.size == 1

      block.call(question, answers.first)
    end
  end

  def lookup_table
    result = {}
    dictionary.each do |answer|
      # NOTE: requires were unclear about case sensistivity. For a case insensitive solution uncomment the following:
      # answer.downcase!
      questions_for_answer(answer).each do |question|
        result[question] ||= []
        result[question] << answer
      end
    end
    result
  end

  # protected

  def questions_for_answer(answer)
    result = []
    (answer.size - 3).times do |i|
      result << answer.slice(i, 4)
    end
    result
  end
end

# this class handles the IO; not worth testing
class Parser
  def initialize(tar_filename, dict_filename = nil, questions_filename = 'questions', answers_filename = "answers")
    @tar_filename = tar_filename
    @dict_filename = dict_filename || tar_filename.split('.').first
    @questions_filename = questions_filename
    @answers_filename = answers_filename
  end

  def call
    write_output! Dictionary.new(read_tar_gz_file.split("\n"))
  end

  protected

  def read_tar_gz_file
    File.open(@tar_filename, "rb") do |file|
      Zlib::GzipReader.wrap(file) do |gz|
        Gem::Package::TarReader.new(gz) do |tar|
          tar.each { |entry|
            return entry.read if entry.full_name == @dict_filename
          }
        end
      end
    end

    ""
  end

  def write_output!(dictionary)
    File.open(@questions_filename, "w") do |questions_file|
      File.open(@answers_filename, "w") do |answers_file|
        dictionary.each_unique_key_pair do |question, answer|
          questions_file.write question + "\n"
          answers_file.write answer + "\n"
        end
      end
    end
  end
end

class TestHarness
  def call
    test_data = %w[arrows carrots give me]
    test_questions = []
    test_answers = []
    expected_questions = %w[carr give rots rows rrot rrow].sort
    expected_answers = %w[carrots give carrots arrows carrots arrows].sort
    test_dict = Dictionary.new(test_data)

    test_dict.each_unique_key_pair do |question, answer|
      test_questions << question
      test_answers << answer
    end
    test_questions.sort!
    test_answers.sort!

    puts 'QUESTIONS'
    puts test_questions
    puts 'EXPECTED QUESTIONS'
    puts expected_questions

    raise "didn't yield expected questions" unless test_questions == expected_questions

    puts 'ANSWERS'
    puts test_answers
    puts 'EXPECTED ANSWERS'
    puts expected_answers

    raise "didn't yield expected answers" unless test_answers == expected_answers
  end
end

TestHarness.new.call
Parser.new('words.tar.gz').call
