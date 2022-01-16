require 'rspec/autorun'
require './words_list.rb'

describe WordsList do
  let(:words)     { File.read("words_test").split("\n") }
  let(:questions) { %w[rrow rows carr rrot rots give boot ootb otbo tboo] }
  let(:answers)   { %w[arrows arrows carrots carrots carrots give bootboot bootboot bootboot bootboot] }
  
  subject { WordsList.new("words_test") }

  before(:each) do
    subject.generate_questions_and_answers
    subject.write_output
  end

  it "imports words from file" do
    expect(subject.words).to eq(words)
  end

  it "no answers under four letters" do
    expect(File.read("words_test").split("\n")).to include("me")
    expect(File.read("answers").split("\n")).not_to include("me")
  end

  it "removes four letter sequences in different words" do
    expect(File.read("words_test").split("\n")).to include("arrows", "carrots")
    expect(File.read("questions").split("\n")).not_to include("arro")
  end

  it "keeps repeating four letter sequences in the same word" do
    expect(File.read("words_test").split("\n")).to include("bootboot")
    expect(File.read("questions").split("\n")).to include("boot")
  end

  it "tests file creation for answer and questions" do
    expect(File.read("questions").split("\n")).to match_array(questions)
    expect(File.read("answers").split("\n")).to match_array(answers)
  end
end