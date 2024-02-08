
class Dict
  ROOT_PATH       = Dir.pwd
  FILE_WORDS      = "#{ROOT_PATH}/words.txt"
  FILE_QUESTIONS  = "#{ROOT_PATH}/questions.txt"
  FILE_ANSWERS    = "#{ROOT_PATH}/answers.txt"
  
  attr_accessor :all_words, :filtered_words, :all_questions_hash
  attr_accessor :file_w, :file_q, :file_a, :do_puts

  def initialize(file_w: nil, file_q: nil, file_a: nil, do_puts: true)
    @file_w = file_w || FILE_WORDS
    @file_q = file_q || FILE_QUESTIONS
    @file_a = file_a || FILE_ANSWERS
    @do_puts = do_puts

    @all_words = File.open(@file_w).read.split("\n")
  end

  def run
    initialize_files
    puts "@all_words count: #{count_words(@all_words)}" if @do_puts 
    @filtered_words = filter_words(@all_words)
    puts "@filtered_words count: #{count_words(@filtered_words)}" if @do_puts
    get_all_questions_hash
    write_questions_and_answers_files
  end

  def initialize_files
    write_file(@file_q)
    write_file(@file_a)
  end

  def write_questions_and_answers_files
    @all_questions_hash.each_pair do |k,v|
      if v['count'] == 1
        append_file(@file_q, "#{k}\n")
        append_file(@file_a, "#{v['word'][0]}\n")
      end
    end
    puts "Questions File written: #{@file_q}" if @do_puts
    puts "Answers File written: #{@file_a}" if @do_puts
  end

  def write_file(file)
    f = File.open(file, "w")
    f.close
  end

  def append_file(file, data = nil)
    f = File.open(file, "a+")
    f.write(data)
    f.close
  end

  def read_file(file)
    f = File.open(file, "r")
    f.read
    f.close
  end

  def count_words(words)
    words.length
  end

  def filter_words(words)
    @filtered_words = words.reject{|w| w.length < 4}
  end

  def get_all_questions_hash
    @all_questions_hash = {}

    @filtered_words.each_with_index do |w, i|
      initial_w_length = w.length
      curr_w_length = w.length
      w_temp = w

      while curr_w_length > (initial_w_length - 4)
        four_letters = w_temp[0..3]

        if @all_questions_hash[four_letters] == nil
          @all_questions_hash[four_letters] = {}
          @all_questions_hash[four_letters]['word'] = []
          @all_questions_hash[four_letters]['count'] = 0
        end
        @all_questions_hash[four_letters]['word'] << w
        @all_questions_hash[four_letters]['count'] += 1

        if w_temp.length > 4 
          w_temp = w_temp.split('').drop(1)
          w_temp = w_temp.join('')
          curr_w_length = w_temp.length
        else
          curr_w_length = 0
        end

      end
    end

    puts "@all_questions_hash generated" if @do_puts
  end
end