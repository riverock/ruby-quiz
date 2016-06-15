

# The sequencer takes a list of words, and emits an array of all the
# n-length sequences unique to those words. By default, n == 4.

class LetterSequence::Sequencer

  def initialize(wordlist, length: 4)

    @wordlist = wordlist
    @sequence_length = length

  end

  # Returns the questions and answers
  #
  # @return [Hash]
  #   questions: [Array] `@sequence_length` sets of letters in the list of words
  #   answers: [Array] words with unique sequences
  def find_sequences
    seq = dedup_sequences(sequence_words)
    questions = seq.map{|entry| entry[:sequences]}.flatten
    answers = questions.map{|q| @wordlist.select{|w| w.include?(q)}}.flatten
    {questions: questions, answers: answers}
  end


  # Rolls through the list of words, looking for `@sequence_length` sets of letters
  #
  # @results [Array] - Array of Hashes with:
  #   word: [String] - original word
  #   sequences: [Array of String] - `@sequence_length` letter sequences
  def sequence_words
    @wordlist.map do |word|
      scan_word(word)
    end
  end

  def dedup_sequences(sequence_list)
    all_sequences = sequence_list.map{|entry| entry[:sequences]}.
      flatten.
      sort

    duplicates = all_sequences.detect do |e|
      all_sequences.count(e) > 1
    end

    sequence_list.map do |entry|
      {
        word: entry[:word],
        sequences: entry[:sequences].reject {|s| duplicates.include?(s)}
      }
    end
  end

  # Finds the unique `@sequence_length` strings in the word
  #
  # @returns [Hash] - key/value hash:
  #   :word - original word
  #   :sequences - Array of Strings with unique `@sequence_length` strings
  def scan_word(word)
    scans = word.
      split('').
      each_cons(@sequence_length).
      map{|a| a.join}.
      uniq
    {
      word: word,
      sequences: scans
    }
  end


end
