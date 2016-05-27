class WordProcessor

  LIMIT = 4

  attr_accessor :questions, :answers

  def initialize(path_to_dictionary)
    @dictionary = []
    # read the words file to create an array of words
    File.open(path_to_dictionary, 'r') do |f|
      f.each_line do |line|
        @dictionary << line.strip.downcase
      end
    end
  end

  def process
    # process the dictionary array to create the questions
    @processed_words = {}
    @dictionary.each do |word|
      word_substrings = all_substrings(word)
      word_substrings.each do |current_pattern|
        if current_pattern_info = @processed_words[current_pattern]
          current_pattern_info[:count] += 1
          current_pattern_info[:words] << word
        else
          @processed_words[current_pattern] = {count: 1, words: [word]}
        end
      end
    end
    @questions = []
    @answers = []
    @processed_words.each do |pattern, info|
      if info[:count] == 1
        @questions << pattern
        @answers << info[:words].first
      end
    end
   write_file(@questions, "questions")
   write_file(@answers, "answers")
  end

  def write_file(array, name)
    File.open(name + ".txt", "w+") do |f|
      f.puts(array)
    end
  end

  def all_substrings(word, limit=LIMIT)
    len = word.size
    if len >= LIMIT
      (0..len-LIMIT).inject([]) do |arr,i|
        arr << word[i,limit]
      end
    else
      []
    end
  end

  def self.run_program(path='words')
    processor = WordProcessor.new path
    processor.process
  end

end
