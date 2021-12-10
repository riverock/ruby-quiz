require 'word_file_generator'

describe WordFileGenerator do
  let(:words_array) { ['arrows', 'carrots', 'give', 'me'] }
  let(:questions_array) { ['carr', 'give', 'rots', 'rows', 'rrot', 'rrow'] }
  let(:answers_array) { ['carrots', 'give', 'carrots', 'arrows', 'carrots', 'arrows'] }
  let(:generator) { WordFileGenerator.new('four_words.txt')}

  describe '#init' do
    it 'loads a word list from a file' do
      expect(generator.words).to eq words_array
    end

    it 'turns the given word list into a hash' do
      expect(generator.q_and_a_hash.keys.sort).to eq questions_array.sort
    end
  end

  describe '#split_word' do
    it 'skips words with fewer than four letters' do
      expect(generator.split_word('abc')).to eq nil
      expect(generator.split_word('ab')).to eq nil
      expect(generator.split_word('a')).to eq nil
    end

    it 'splits a given word into all its four-letter subwords' do
      expect(generator.split_word('abcdef')).to eq ['abcd', 'bcde', 'cdef']
    end
  end

  describe '#process' do
    it 'works' do
      expect(generator.process.keys).to match_array [:questions, :answers]
      expect(generator.process[:questions]).to match_array questions_array
      expect(generator.process[:answers]).to match_array answers_array
    end
  end
end
