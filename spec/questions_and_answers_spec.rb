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

# describe "#get_words_array" do
#   it "should return the correct array" do
#     expect get_words_array('basic_example/words') == %w(arrows carrots give me)
#   end
# end
#
# describe "#questions_and_answers" do
#   words_array = get_words_array('basic_example/words')
#   questions, answers = questions_and_answers(words_array)
#   questions_correct = get_words_array('basic_example/questions_correct')
#   answers_correct = get_words_array('basic_example/answers_correct')
#
#   it "should return the correct questions" do
#     expect(questions) == "hi"
#   end
#
#   # it "should return the correct answers" do
#   #   expect answers == answers_correct
#   # end
# end
