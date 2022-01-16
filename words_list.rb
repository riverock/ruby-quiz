require 'pry'

class WordsList
    attr_accessor :words, :combinations

    def initialize(words_file)
        @words = File.read(words_file).split("\n")
    end

    def generate_questions_and_answers
        @combinations = Hash.new
        duplicates = Hash.new

        words.each_with_index do |word, index|
            next if word.length < 4

            start_index = 0
            end_index = 3
            while end_index < word.length

                # Skip if duplicate 4 letter sequence exists
                if duplicates[word[start_index..end_index]]
                    start_index += 1
                    end_index += 1
                    next
                end

                # Remove from sequences and add to duplicates. Check if the same sequence appears in the same word
                if @combinations.has_key?(word[start_index..end_index]) && @combinations[word[start_index..end_index]] != word
                    duplicates[word[start_index..end_index]] = true
                    @combinations.delete(word[start_index..end_index])
                    start_index += 1
                    end_index += 1
                    next
                end

                # Add sequence and word combo
                @combinations[word[start_index..end_index]] = word

                start_index += 1
                end_index += 1
            end

        end
    end

    def write_output
        questions_file = File.open('questions', 'w')
        answers_file = File.open('answers', 'w')

        combinations.each do |key, value|
            questions_file.puts key
            answers_file.puts value
        end

        questions_file.close
        answers_file.close
    end
end

words = WordsList.new("words")
words.generate_questions_and_answers
words.write_output