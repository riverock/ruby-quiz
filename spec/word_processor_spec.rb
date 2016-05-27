require 'spec_helper'
require 'word_processor'

describe WordProcessor do

  let(:word_processor) { WordProcessor.new 'test_words.txt' }

  context 'when you call all_substrings with a word that is bigger than the configured LIMIT' do
     it 'returns the correct result' do
       expect(word_processor.all_substrings("thebig")).to eq(%w(theb hebi ebig))
     end
  end

  context 'when you call all_substrings with a word that is smaller than the configured LIMIT' do
     it 'returns an empty array' do
       expect(word_processor.all_substrings("the")).to be_empty
     end
  end

  context 'when you provide a words file' do
     it 'returns the correct results' do
       word_processor.process
       expect(word_processor.questions).to eq(%w(cool ooli olio lios derf erfu rful esti stie ties))
       expect(word_processor.answers).to eq(%w(coolios coolios coolios coolios wonderful wonderful wonderful besties besties besties))
     end
  end

end
