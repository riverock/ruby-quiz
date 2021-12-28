# frozen_string_literal: true

require "minitest/autorun"
require "generate_questions_answers"

describe GenerateQuestionsAnswers do
  it "generates accurate output" do
    words_file = File.join(File.dirname(__FILE__), "sample_words")
    questions, answers = GenerateQuestionsAnswers.new(words_file, false).call

    _(questions).must_equal %w[carr give rots rows rrot rrow]
    _(answers).must_equal %w[carrots give carrots arrows carrots arrows]
  end
end
