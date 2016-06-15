require "test_helper"

class LetterSequence::SequencerTest < Minitest::Test

  def setup
    @wordlist = %w[arrows carrots give me]
    @sequencer = LetterSequence::Sequencer.new(@wordlist)
  end

  def teardown

  end

  def test_find_sequences
    exp = {
      questions: %w[carr give rots rows rrot rrow],
      answers: %w[carrots give carrots arrows carrots arrows]
    }
    seq = @sequencer.find_sequences
    assert_kind_of Hash, seq
    assert_equal exp.keys.sort, seq.keys.sort
    assert_equal exp[:questions].sort, seq[:questions].sort
    assert_equal exp[:answers].sort, seq[:answers].sort
  end

  def test_sequence_words
    exp = [
      {
        word: "arrows",
        sequences: ["arro", "rrow", "rows"]
      },
      {
        word: "carrots",
        sequences: ["carr", "arro", "rrot", "rots"]
      },
      {
        word: "give",
        sequences: ["give"]
      },
      {
        word: "me",
        sequences: []
      }
    ]
    seq = @sequencer.sequence_words
    assert_kind_of Array, seq
    seq.each do |rec|
      assert_kind_of Hash, rec
    end

    assert_equal exp.length, seq.length
    assert_equal exp.map{|e| e[:word]}.sort, seq.map{|e| e[:word]}.sort
    assert_equal exp.map{|e| e[:sequences].sort}.sort, seq.map{|e| e[:sequences].sort}.sort
  end


  def test_dedup_sequences
    data = [
      {
        word: "arrows",
        sequences: ["arro", "rrow", "rows"]
      },
      {
        word: "carrots",
        sequences: ["carr", "arro", "rrot", "rots"]
      },
      {
        word: "give",
        sequences: ["give"]
      },
      {
        word: "me",
        sequences: []
      }
    ]

    exp = [
      {
        word: "arrows",
        sequences: ["rrow", "rows"]
      },
      {
        word: "carrots",
        sequences: ["carr", "rrot", "rots"]
      },
      {
        word: "give",
        sequences: ["give"]
      },
      {
        word: "me",
        sequences: []
      }
    ]

    seq = @sequencer.dedup_sequences(data)
    assert_kind_of Array, seq
    seq.each do |rec|
      assert_kind_of Hash, rec, rec.inspect
    end

    assert_equal exp.length, seq.length
    assert_equal exp.map{|e| e[:word]}.sort, seq.map{|e| e[:word]}.sort
    assert_equal exp.map{|e| e[:sequences].sort}.sort, seq.map{|e| e[:sequences].sort}.sort
  end

  def test_scan_word
    exp = {word: "carrots", sequences: %w[carr arro rrot rots]}
    scans = @sequencer.scan_word(exp[:word])
    assert_kind_of Hash, scans
    assert_equal exp.keys.sort, scans.keys.sort
    assert_equal exp[:word], scans[:word]
    assert_equal exp[:sequences].sort, scans[:sequences].sort
  end

end
