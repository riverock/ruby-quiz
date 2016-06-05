require 'fileutils'
class Quiz
  attr_accessor :questions, :answers

  def initialize()
    @questions = []
    @answers = []
  end

  def extract_unique(dictionary, word_length=4)
    uniques = Hash.new(0)
    answers = Hash.new(0)

    dictionary.each_with_index do |word,idx|
      next if word.size < word_length
      word.chars.each_cons(word_length) do |char_group|
        char = char_group.join
        uniques[char] += 1
        answers[char] = idx
      end
    end
    repeats = uniques.reject{ |v,k|k==1 }.keys
    repeats.each do |r|
      uniques.delete(r)
      answers.delete(r)
    end

    @questions = uniques.keys

    answers.values.each do |v|
      @answers << dictionary[v]
    end

    Dir.mkdir('out') unless File.exists?('out/answers')
    File.open('out/questions', 'w') { |f| @questions.each { |q| f.write(q.to_s + "\n") } }
    File.open('out/answers', 'w') { |f| @answers.each { |a| f.write(a.to_s + "\n") } }
  end
end
