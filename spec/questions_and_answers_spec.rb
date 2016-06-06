require 'spec_helper'

describe '#sequences_from_word' do
  it 'returns the correct sequences from arrows' do
    expect(sequences_from_word('arrows')).to eql %w(arro rrow rows)
  end
  it 'returns the correct sequences from carrots' do
    expect(sequences_from_word('carrots')).to eql %w(carr arro rrot rots)
  end
  it 'returns the correct sequences from give' do
    expect(sequences_from_word('give')).to eql %w(give)
  end
end

describe "#get_words_array" do
  it "should return the correct array" do
    expect(get_words_array('basic_example/words')).to eql %w(arrows carrots give me)
  end
end

# This test helped me realize that you DON'T include a sequence if it's in any other word
# I previously thought you include the sequence, but DON'T count it for the other words it's in
describe "#questions_and_answers" do
  words_array = get_words_array('basic_example/words')
  questions, answers = questions_and_answers(words_array).map { |x| x[:array] }
  questions_correct = get_words_array('basic_example/questions_correct').sort
  answers_correct = get_words_array('basic_example/answers_correct').sort

  it "should return the correct questions" do
    expect(questions).to eql questions_correct
  end

  it "should return the correct answers" do
    expect(answers).to eql answers_correct
  end
end
