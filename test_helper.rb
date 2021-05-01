# Testing methods
def should_return_error_message # Testing for when the file you provide is not found or not valid.
  expect(GenerateQuestions.new('not_valid_words.tar.gz').extract_words_from_file).to eq("Error, Cannot find or read file.")
end

def should_extract_words_from_file # testing method extract_words_from_file.
  create_new_instance
  expect(@instance.words).to eq([])
  expect(@instance.extract_words_from_file).not_to eq([])
  expect(@instance.words).not_to eq([])
  expect(@instance.extract_words_from_file).to eq(@instance.words)
end

def should_generate_sequences # testing method generate_sequences.
  create_new_instance
  @instance.extract_words_from_file
  expect(@instance.questions).to eq([])
  expect(@instance.generate_sequences).not_to eq({})
  should_make_sequences_for_one_word # Testing private method.
end

def should_make_sequences_for_one_word # testing private method make_sequences(word).
  expect(GenerateQuestions.new('').send(:make_sequences, 'carrots')).to eq(['carr', 'arro', 'rrot', 'rots'])
end

def should_add_questions_and_answers # testing method add_questions_and_answers.
  create_new_instance
  @instance.extract_words_from_file
  @instance.generate_sequences
  expect(@instance.questions).to eq([])
  expect(@instance.answers).to eq([])
  expect(@instance.add_questions_and_answers).not_to eq([])
  expect(@instance.questions).not_to eq([])
  expect(@instance.answers).not_to eq([])
end

def should_generate_files # testing method generate_files.
  create_new_instance
  @instance.words = ['arrows', 'carrots']
  @instance.generate_sequences
  @instance.add_questions_and_answers
  # @instance.generate_files
  expect(@instance.generate_files).not_to eq("Error")
  expect(@instance.generate_files).to eq("Files Created")
  answer_file, question_file = File.open("answers.txt","r"), File.open("questions.txt","r")
  should_write_one_word_per_line
  expect(@instance.questions.sort).to eq(['carr', 'rots', 'rows', 'rrot', 'rrow'].sort)
end

def create_new_instance
  @instance = GenerateQuestions.new('words.tar.gz')
end

# Testing Whole Process
def should_generate_questions_and_answers_files
  expect(File).to exist("./questions.txt")
  expect(File).to exist("./answers.txt")
end

def should_write_one_word_per_line
  answer_file, question_file = File.open("answers.txt","r"), File.open("questions.txt","r")
  answer_file_line_count = answer_file.readlines.size
  question_file_line_count = question_file.readlines.size
  expect(answer_file_line_count).to eq(question_file_line_count)
  expect(question_file_line_count).to eq(@instance.questions.size)
  expect(answer_file_line_count).to eq(@instance.answers.size)
end

# Below are testing based on the given examples from the README.
def should_match_expected_results
  expect(@instance.questions.sort).to eq(['carr', 'give', 'rots', 'rows', 'rrot', 'rrow'].sort)
  expect(@instance.answers.sort).to eq(['carrots', 'give', 'carrots', 'arrows', 'carrots', 'arrows'].sort)
end

def should_align_questions_and_answers_on_the_same_line
  expected_alignment = { rrow: 'arrows', rows: 'arrows', carr: 'carrots', rrot: 'carrots', rots: 'carrots', give: 'give' }
  aligned_result = {}
  questions, answers = @instance.questions, @instance.answers
  questions.each_with_index { |question, idx| aligned_result[question.to_sym] = answers[idx] }
  expect(expected_alignment).to eq(aligned_result)
end