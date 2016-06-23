class WordParser
  attr_reader :words_hash

  def initialize(file)
    @words_hash= {}
    @file= file
  end

  def read_file(file)
    begin
      File.readlines(@file).each do |line|
        @words_hash[line.chomp] = nil
      end
    rescue Exception => e
      puts "unable to read file :: #{e}"
    end
  end

  def parse
    @words_hash.each do |word,classification|
      @words_hash[word] = word.match(/^.{4}$/) ? :question : :answer
    end
  end

  def save_output
    questions_file = create_file("questions")
    answers_file = create_file("answers")
    @words_hash.each do |word,classification|
      if classification == :question
        questions_file.write(word+"\n")
      elsif classification == :answer
        answers_file.write(word+"\n")
      end
    end
  end

  def parse_and_save
    parse
    save_output
  end

  private

  def create_file(file_name)
    begin
      return File.open(file_name, "w")
    rescue Exception => e
      puts "unable to create file : #{e}"
    end
  end
end

wordparser = WordParser.new("words")
wordparser.read_file("words")
wordparser.parse_and_save