require 'spec_helper'

describe '#sequences_from_word' do
  it 'returns the correct sequences' do
    expect QuestionsAndAnswers.sequences_from_word('arrows') == %w(arro rrow rows)
  end
end
