class WordFileGenerator
  attr_accessor :words, :q_and_a_hash

  def initialize(filename)
    actual_path = File.expand_path(filename)
    @words = File.readlines(actual_path).map{ |word| word.strip }
    create_q_and_a_hash
  end

  def create_q_and_a_hash
    @q_and_a_hash = {}

    big_words = @words.select { |item| item.length >= 4 }
    deleted_words = []

    big_words.each do |word|
      split_word(word).each do |subword|
        if @q_and_a_hash.has_key? subword
          @q_and_a_hash.delete subword
          deleted_words << subword
        else
          @q_and_a_hash[subword] = word
        end
      end
    end
  end

  def process
    {
      questions: questions,
      answers: answers
    }
  end

  def self.solve_problem
    generator = WordFileGenerator.new('words.txt')
    generator.generate_files('final')
  end

  def generate_files(root)
    File.open("#{root}_questions", "w+") do |f|
      f.puts(questions)
    end

    File.open("#{root}_answers", "w+") do |f|
      f.puts(answers)
    end
  end

  def questions
    @q_and_a_hash.keys
  end

  def answers
    questions.map { |key| @q_and_a_hash[key] }
  end

  def split_word(word)
    return nil if word.length < 4

    (0..word.length - 4).map { |x| word[x..x+3] }
  end
end
