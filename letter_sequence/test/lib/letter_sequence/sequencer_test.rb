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
    exp = {
      "arro" => ["arrows", "carrots"],
      "rrow" => ["arrows"],
      "rows" => ["arrows"],
      "carr" => ["carrots"],
      "rrot" => ["carrots"],
      "rots" => ["carrots"],
      "give" => ["give"]
    }
    @sequencer.sequence_words
    assert_equal exp, @sequencer.sequence_hash
  end


  def test_dedup_sequences
    exp = {
      "rrow" => ["arrows"],
      "rows" => ["arrows"],
      "carr" => ["carrots"],
      "rrot" => ["carrots"],
      "rots" => ["carrots"],
      "give" => ["give"]
    }

    @sequencer.sequence_words
    @sequencer.dedup_sequences

    assert_equal exp, @sequencer.sequence_hash
  end

  def test_scan_word
    input = "carrots"
    exp = %w[carr arro rrot rots]
    scans = @sequencer.scan_word(input)
    assert_kind_of Array, scans
    assert_equal exp.sort, scans.sort
  end

end
