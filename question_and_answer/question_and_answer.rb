class QuestionAndAnswer
	attr_reader :file, :dictionary, :fragments

	def initialize (file)
		@file = file
		@dictionary = []
		@fragments = {}
	end

	def get_dictionary
		self.file.each_line('/n') do |line| 
			@dictionary << line.chomp('/n')
		end
		self
	end

	def word_count_cleanup
		self.dictionary.keep_if {|entry| entry.length > 3}
		self
	end

	def fragmentize
		self.dictionary.each do |word|
				@fragments[word] = []
				n = 0
				while 3 + n < word.length
					@fragments[word].push word[n..(3 + n)]
					n += 1
				end
			end
		self
	end

	def find_unique_fragments(question_path, answer_path)
		q = File.new(question_path, 'w')
		a = File.new(answer_path, 'w')
		self.dictionary.each do |word|
			self.fragments[word].each do |fragment|
				matches = 0
					if fragment.match(word)
						matches += 1
					end
				if matches === 1
					q.puts fragment + '/n'
					a.puts word + '/n'
				end	
			end
		end
		q.close
		a.close
	end
end


RSpec.describe QuestionAndAnswer do

	let(:q_and_a) { QuestionAndAnswer.new(File.open('../Downloads/sample_dictionary'))}

	describe '#initialize' do
		it 'opens a file' do
			expect(q_and_a.file.read).to be_a(String)
		end	
		it 'has an array property' do
			expect(q_and_a.dictionary).to be_a(Array)
		end
	end

	describe 'creates dictionary' do
		it 'populates array from file' do
			q_and_a.get_dictionary
			expect(q_and_a.dictionary.count).to be > 5
		end

		it 'removes all words under 3 letters' do
			q_and_a.get_dictionary
			q_and_a.word_count_cleanup

			expect(q_and_a.dictionary.sample.length).to be >= 4
		end
	end

	describe 'compares four-letter fragments to dictionary' do
		let(:dictionary_array) {q_and_a.get_dictionary.word_count_cleanup}
		it 'creates four-letter fragments of each word' do
			d = dictionary_array.fragmentize
			expect(d.fragments).to be_a(Hash)
			expect(d.fragments).not_to be_empty
		end

		it 'compares each fragment to dictionary' do
			d = dictionary_array.fragmentize
			d.find_unique_fragments('../Downloads/questions.txt', '../Downloads/answers.txt')

			expect(File.open('../Downloads/questions.txt')).to be_a(File)
		end
	end
end
