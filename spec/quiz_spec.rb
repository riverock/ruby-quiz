require 'spec_helper'

describe Quiz do
  let(:dictionary) {{ :key => 'value' }}
  let(:word_length) { 4 }

  describe '.extract_unique(words, word_length)' do
    it 'generates an output of questions' do
      pending
      # should be a list of every sequence of length word_length that appears
      # exactly once in the dictionary, one sequence per line.
    end

    it 'generates an output of answers' do
      # should be a list of corresponding words that contain sequences, in same order
    end
  end
