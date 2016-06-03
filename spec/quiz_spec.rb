require 'spec_helper'

RSpec.describe Quiz do
  let(:dictionary) { ['arrows', 'carrots', 'give', 'me']}
  let(:word_length) { 4 }

  describe '.extract_unique(dictionary, word_length)' do
    it 'generates an output of questions' do
      quiz = Quiz.new
      quiz.extract_unique(dictionary, word_length)
      expect(quiz.questions).to eq(['rrow', 'rows', 'carr', 'rrot', 'rots', 'give'])
      # should be a list of every sequence of length word_length that appears
      # exactly once in the dictionary, one sequence per line.
    end

    it 'generates an output of answers' do
      quiz = Quiz.new
      quiz.extract_unique(dictionary, word_length)
      expect(quiz.answers).to eq(['arrows', 'arrows', 'carrots', 'carrots', 'carrots', 'give'])
      # should be a list of corresponding words that contain the question sequences, in same order
    end
  end
end
