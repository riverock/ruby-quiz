def questions(q)
  open('questions', 'a') { |x|
    x.puts q
  }
end

def answers(a)
  open('answers', 'a') { |x|
    x.puts a
  }
end

#read through file with IO
IO.foreach("words") {|x|
  word_size = x.strip.size # Gather amount of actually characters.
  word = x.strip # Enter just the word into word variable.
  word_tmp = x.strip # Create another variable to be subtracted from for output in the until statement.
  
  
  if word_size >= 4 # If the word size is greater than or equal to 4 continue.
    if word[0,4] !~ /\d/ # Check to make sure just letters go into the questions file.
      questions(word[0,4])
      answers(word)
    end 
    if word_size > 4 # If word size is greater than 4 continue.
      until word_size <= 4 do#  Run until the word_temp variable is less than four.
        word_tmp[0] = '' # Delete the first letter as it has already been accounted for.
        if word_tmp[0,4] !~ /\d/ # Check to make sure just letters go into the questions file.
          questions(word_tmp[0,4])
          answers(word)
        end 
        word_size = word_size - 1 # Change word value for until statement.
      end
    end
  end 
}