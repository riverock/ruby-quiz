# solution.rb
require 'test/unit'
`tar -xf words.tar.gz`


class Array
  def duplicates_count
    uniq.sort.map{ |qs|
      if ( count = grep(qs).size ) == 1
        { qs => count }
      end
    }.compact
  end
end


# Create an array of all the four-letter strings from the word list
fourls = []

File.foreach("words") do |word|
	if word =~ /[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z]/
		word.chomp
		x = word.length
		n = 0
		while n < (x-4)
			unless word[n, 4] =~/[^a-zA-Z]/
				fourls << "#{word[n, 4].downcase}"
			end
			n += 1
		end
	end
end

# Count the occurrence of each four-letter string combination and outputs a hash of those that only occur once
fourls_combos = []
fourls_combos = fourls.duplicates_count

# Use the four-letter string hash to get questions
questions = []
fourls_combos.each do |key, value|
  questions << key.to_s[2,4]
end

# Print the questions to file
File.open("questions", "w+") do |q|
  q.puts(questions)
end


# Create a hash of four-letter strings and the words they appear in
qas = {}

File.foreach("words") do |word|
  if word =~ /[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z]/
    word.chomp
    x = word.length
    n = 0
    while n < (x-4)
      unless word[n, 4] =~/[^a-zA-Z]/
        qas["#{word[n, 4].downcase}"] = word.chomp
      end
      n += 1
    end
  end
end

# Use the hash to get the corresponding answer value using the question keys
answers = qas.values_at(*questions)

# Write answers to file
File.open("answers", "w+") do |a|
  a.puts(answers)
end



