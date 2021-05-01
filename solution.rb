require 'rubygems/package'
require 'zlib'

class GenerateQuestions
  attr_accessor :file_name, :words, :questions, :answers

  def initialize(file_name, words=nil, run=nil)
    @words = words || []
    @file_name, @questions, @answers = file_name, [], []
    run_process if run
  end

  def run_process
    extract_words_from_file if @words.empty?  # gets the words from the file provided.
    generate_sequences # looks and finds sequences for every word.
    add_questions_and_answers # This helper method will add the questions and answers correspondingly to the arrays.
    generate_files # creates questions and answers files.
    puts "questions count: #{@questions.size}"
    puts "answers count: #{@answers.size}"
    puts "Check the questions and answers files that are generated!"
  end

  def extract_words_from_file
    begin
      tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open("./#{@file_name}"))
      tar_extract.each do |entry|
        if entry.full_name == 'words'
          entry.read.each_line do |word|
            new_word = word.strip # Removing the whitespace of the word! "AAAS\n" => "AAAS".
            if new_word.length >= 4 && new_word[/[a-zA-Z]+/] == new_word # only pushing words that are 4 letters or more and real words with only letters.
              @words.push(new_word)
            end
          end
        end
      end
      tar_extract.close
    rescue => exception
      # puts exception.message
      return "Error, Cannot find or read file."
    end
    @words
  end

  def generate_sequences
    @word_map_hash, @sequence_hash = {}, {} # using hash to sort duplicate sequences and to map sequences to their original word.
    @words.each do |word|
      make_sequences(word).each do |sequence| # make_sequences(word) is a helper method that gets all sequences for a single word.
        if @sequence_hash[sequence]
          @sequence_hash[sequence] = false
          @word_map_hash[sequence] = false
        else
          @word_map_hash[sequence] = word
          @sequence_hash[sequence] = 1
        end
      end
    end
    @sequence_hash
  end

  def add_questions_and_answers # We are only adding sequences that are only from one word.
    @sequence_hash.each do |sequence, count|
      if count == 1 && @word_map_hash[sequence]
        @questions.push(sequence)
        @answers.push(@word_map_hash[sequence])
      end
    end
    @questions
  end

  def generate_files # writing each qustion on new line, same for the answer.
    begin
      File.open("questions.txt", "w") do |f|
        @questions.each { |question| f.write("#{question}\n") }
      end
      
      File.open("answers.txt", "w") do |f|
        @answers.each { |answer| f.write("#{answer}\n") }
      end
      return 'Files Created'
    rescue => exception
      return 'Error'
    end
  end

  private

  def make_sequences(word)
    sequences = []
    word_count = word.length
    (0..word_count - 1).each do |idx1|
      (idx1..word_count - 1).each do |idx2|
        sequence = word[idx1..idx2]
        sequences.push(sequence) if sequence.length == 4 # pushing sequence that is exactly 4 letters.
      end
    end
    sequences
  end

end

instance = GenerateQuestions.new('words.tar.gz')
instance.run_process