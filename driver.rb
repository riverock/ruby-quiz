require_relative 'ruby_quiz'

ruby_quiz = RubyQuiz.new('words')

ruby_quiz.define_questions
ruby_quiz.find_answers

puts "Done!"
