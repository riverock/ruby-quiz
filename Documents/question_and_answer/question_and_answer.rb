class QuestionAndAnswer
	require "rubygems/package"
	require "zlib"

def initialize (file)
	@file = file
end

def get_dictionary
	@file.open
end

