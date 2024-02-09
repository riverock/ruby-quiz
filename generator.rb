class Generator

  def initialize(filepath)
    @words = []
    File.readlines(filepath, chomp: true).each do |line|
      @words << line
    end
  end

  def generate_files
    questions = []
    answers = []
    @words.each do |word|
      res = word.scan(/.{1,4}/)
      res.each do |result|
        if result.length == 4
          answers << word
          questions << result
        end
      end
    end

    answers.uniq!
    questions.uniq!

    File.write("questions.txt", questions.join("\n"), mode: "w")
    File.write("answers.txt", answers.join("\n"), mode: "w")
    "Files generated Successfully"
  end
end
