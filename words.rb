# The main method to call.
def run_words
	dictionary = get_data
	seq = sequences(dictionary, 4)
	
	# Make the sequence of letters unique.
	seq.uniq!
	
	# Find all single instances in the words
	questions = get_questions(seq, dictionary)
	write_file('questions.txt', questions.keys)

	# Find the answers to all the questions
	answers = get_answers(questions.keys, dictionary)
	write_file('answers.txt', answers)
	return 'Complete!'
end

# Read the dictionary and remove extraneous line breaks
def get_data
	data = File.readlines('words.txt').map{ |line| line.gsub("\n", '') }
	return data
end

def write_file(filename, data)
	File.open(filename, "w+") do |f|
		data.each { |item| f.puts(item) }
	end
end

# Get all letter sequences
def sequences(data, length)
	sequences = []	
	data.each do |d|
		# Only concern ourselves with words longer than the specified length
		if d.length >= length
			# Step through the range of strings of the specified length
			(0..(d.length-length)).each { |n|
				sequences << d[n, length]
			}
		end
	end
	return sequences
end

def get_questions(data, dictionary)
	questions = Hash.new 0
	dictionary.each do |d|
		data.each do |q|
			if d.include? q
				if questions.key?(q)
					questions[q] = questions[q]+1
				else
					questions[q] = 1
				end			
			end
		end	
	end
	questions.delete_if{|_,v| v != 1}
	return questions
end

def get_answers(data, dictionary)
	answers = []
	data.each do |q|
		dictionary.each do |d|
			if d.include? q
				answers << d
			end
		end
	end
	return answers
end
