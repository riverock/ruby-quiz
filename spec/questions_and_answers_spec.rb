require 'spec_helper'

describe '#sequences_from_word' do
  it 'returns the correct sequences from arrows' do
    expect QuestionsAndAnswers.sequences_from_word('arrows') == %w(arro rrow rows)
  end
  it 'returns the correct sequences from carrots' do
    expect QuestionsAndAnswers.sequences_from_word('carrots') == %w(carr arro rrot rots)
  end
  it 'returns the correct sequences from give' do
    expect QuestionsAndAnswers.sequences_from_word('give') == %w(give)
  end
end
