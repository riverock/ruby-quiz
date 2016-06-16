class LetterSequence::Sequencer

  attr_reader :sequence_hash

  def initialize(wordlist, length: 4)

    @wordlist = wordlist
    @sequence_length = length
    @sequence_hash = Hash.new {|h,k| h[k] = [] }

  end

  # Returns the questions and answers
  #
  # @return [Hash]
  #   questions: [Array] `@sequence_length` sets of letters in the list of words
  #   answers: [Array] words with unique sequences
  def find_sequences
    sequence_words
    dedup_sequences
    {
      questions: @sequence_hash.keys,
      answers: @sequence_hash.values.flatten
    }
  end

  # Removes keys from @sequence_hash that have more than one word
  #
  # Nothing returned of consequence, @sequence_hash modified
  def dedup_sequences
    @sequence_hash = @sequence_hash.reject{|k,v| v.length > 1 }
  end


  # Pushes the word onto each sequence key in the @sequence_hash
  #
  # Nothing returned of consequence, @sequence_hash modified
  def sequence_words
    @wordlist.each do |word|
      scans = scan_word(word)
      scans.each do |scan|
        @sequence_hash[scan].push(word)
      end
    end
  end

  # Finds the unique `@sequence_length` strings in the word
  #
  # @returns [Array of Strings] - the sequences
  def scan_word(word)
    word.
      split('').
      each_cons(@sequence_length).
      map{|a| a.join}.
      uniq
  end
end
