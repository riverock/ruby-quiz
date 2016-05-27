#!/usr/env/ruby ruby
`tar -xf words.tar.gz`

@answers = File.open('answers.txt', 'w+')
@questions = Array.new

def get_questions(answer, fragment=answer)
  question = fragment[0..3]
    write_files(question, answer)
    next_fragment = fragment.reverse.chop.reverse
    if next_fragment.length >= 4
      get_questions(answer, next_fragment)
    else
      return
    end
end

def write_files(question, answer)
  if @questions.include?(question)
    return
  else
    @questions << question
    @answers << "#{answer}\n"
  end
end

File.open("words") do |dictionary|
  dictionary.each_line do |line|
    answer = line.chomp
    get_questions(answer)
  end
end

@answers.close

 File.open('questions.txt', 'w+') do |f|
  @questions.each do |question|
    f << "#{question}\n"
  end
 end
