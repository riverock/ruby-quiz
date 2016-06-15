class QuestionAndAnswer
	attr_reader :file, :dictionary

	def initialize (file)
		@file = file.read
		@dictionary = []
	end

	def get_dictionary
		@file.each_line {|line| @dictionary << line.chomp}
	end

	def word_count_cleanup
		@dictionary.keep_if {|entry| entry.length > 3}
	end

end

RSpec.describe QuestionAndAnswer do

	let(:q_and_a) { QuestionAndAnswer.new(File.open('../Downloads/words'))}

	describe '#initialize' do
		it 'opens a file' do
			expect(q_and_a.file).to be_a(String)
		end	
		it 'has an array property' do
			expect(q_and_a.dictionary).to be_a(Array)
		end
	end

	describe '#get_dictionary' do
		it 'populates array from file' do
			q_and_a.get_dictionary
			expect(q_and_a.dictionary).not_to be_empty
		end

		it 'removes all words under 3 letters' do
			q_and_a.get_dictionary
			q_and_a.word_count_cleanup

			expect(q_and_a.dictionary.sample.length).to be >= 4
		end


	end
end