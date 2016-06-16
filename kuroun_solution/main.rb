require_relative "words_puzzle"

wp = WordsPuzzle.new(4)
d = "words"
wp.read_file d
count = 0
while(true) do
  word = wp.get_random_word
  sequence = wp.get_sequence_word(word)
  process = wp.add_random_sequence(word, sequence)
  count += 1 if(process==true)
  break if(count==10)  
end
wp.write_questions_answers
wp.clear