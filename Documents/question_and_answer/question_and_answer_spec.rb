require "/question_and_answer"

describe QuestionAndAnswer do
	describe '#initialize' do
		it 'opens a compressed file' do
			q_and_a = QuestionAndAnswer.new('./Downloads/words.tar.gz')
			expect(q_and_a).to be_an_instance_of(QuestionAndAnswer)
		end

		it 'creates an array of words from file' do

		end	
	end
end