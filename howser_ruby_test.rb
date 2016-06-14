split_word_list = {}
duplicate_keys = []
words = []

File.open("words") do |f|
  f.each do |word|
    words << word.chomp.downcase
  end
end

words.each do |word|
  letter_count = word.length
  n = 0

  puts word
  if letter_count <= 4
    split_word_list[word] = word
  else
    while n < (letter_count - 3)
      if split_word_list.has_key?(word[n..n+3]) || duplicate_keys.include?(word[n..n+3])
        duplicate_keys << word[n..n+3]
        split_word_list.delete(word[n..n+3])
      else
        split_word_list[word[n..n+3]] = word
      end
      n += 1
    end
  end
end

open('questions', 'w') do |file|
  file.puts split_word_list.values
end

open('answers', 'w') do |file|
  file.puts split_word_list.keys
end


