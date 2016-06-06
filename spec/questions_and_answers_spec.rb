require 'spec_helper'

describe '#sequences_from_word' do
  it 'returns the correct sequences' do
    sequences_from_word('arrows').should eql %w(arro rrow rows)
  end
end
