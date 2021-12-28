require 'rspec'
require './quiz_factory'

describe 'quiz_factory' do
  let(:result) { {} }
  let(:questions) { {} }
  let(:answers) { {} }

  before do
    QuizFactory.from_file('words', result)
  end

  it 'Check count of quesions' do
    questions_file = File.open('questions', 'r')
    questions = questions_file.read.split
    questions_file.close
    expect(result.length).to eq questions.length
  end

  it 'Check count of answers' do
    answers_file = File.open('answers', 'r')
    answers = answers_file.read.split
    answers_file.close
    expect(result.length).to eq answers.length
  end

  it 'Check whether question is unique' do
    expect(questions.uniq.length).to eq questions.length
  end

  it 'Check questions include some sequences' do
    questions_file = File.open('questions', 'r')
    questions = questions_file.read.split
    questions_file.close
    expect(%w[Abbo idja Brum oali lidg yspl eefu mpst xury Neum idig Rigg Sony ojet dgra lowi].all? { |q| questions.include? q }).to eq(true)
  end
end
