require_relative 'file_handle'

class RubyQuiz
  attr_accessor :actual_words, :words, :chunk, :questions, :answers, :file_name

  def initialize(file_name)
    @actual_words = []
    @words = []
    @chunk = 4
    @questions = []
    @answers = []
    @file_name = file_name
  end


  def define_questions
    file_handle = FileHandle.new(file_name)
    @actual_words = file_handle.read

    actual_words.each do |word|
      word = word.gsub(/'/, '').downcase
      words << word

      (word.size - chunk + 1).times do |i|
        questions << word[i, chunk]
      end
    end

    questions_hash = Hash.new(0)
    questions.each{ |e| questions_hash[e] += 1 }
    questions_hash.delete_if{ |k,v| v != 1 }

    @questions = questions_hash.keys

    file_handle = FileHandle.new('questions', questions)
    file_handle.write
  end


  def find_answers
    questions.each do |question|
      i = words.index{ |word| word.include? question }

      answers << actual_words[i]
    end

    file_handle = FileHandle.new('answers', answers)
    file_handle.write
  end
end
