class WordsPuzzle
  attr_accessor :dictionary, :questions_answers, :num
  def initialize number
    @dictionary = {}
    @questions_answers = {}
    @num = number
    @rand = Random.new
  end
  def read_file d
    count = 0
    File.readlines(d).each do |line|
      line.chomp! #remove hidden char at the end of string
      if((!@dictionary.key?line) && line.length >= @num)
        @dictionary[line] = count  
        count += 1
      end
    end
  end
  def get_random_word
    random_seed =@rand.rand(@dictionary.size)
    random_word = @dictionary.key(random_seed)
  end
  
  #finding sub sequence of random word
  def get_sequence_word random_word
    random_point = random_word.size + 1
    while((random_point + @num) > random_word.size) do
      random_point = @rand.rand(random_word.size)
      break if((random_point+ @num) <= random_word.size)
    end
    sub_word = random_word[random_point...(random_point+@num)]
  end
  
  def add_random_sequence word, sequence 
    random_word = word
    @dictionary[random_word] = nil
    sub_word = sequence
    
    #check if sub sequence contains in more than one word in dictionary
    @dictionary.each do |k,v|
      return false if((k.downcase.include?sub_word.downcase) && (v !=nil))
    end
    @questions_answers[sub_word] = random_word
    true
  end
  
  def write_questions_answers
    questions = File.new("questions","w")
    answers = File.new("answers", 'w')
    @questions_answers.each do |k,v|
      questions.puts(k)
      answers.puts(v)
    end
    questions.close
    answers.close
  end
  
  def clear
    @dictionary = {}
    @questions_answers = {}
  end
end


