class Array
  def conditioner
    self.map {|i| i.sub("'",'') }.
         reject { |i| i.size < SEEK_NUM }
  end
end

class Hash
  def to_questions_file
    keys = self.keys.map(&:to_s)
    q_file = File.expand_path 'files/questions'
    File.open(q_file, "w") do |line|
      keys.each { |i| line.puts i }
    end
    q_file
  end

  def to_answers_file
    values = self.values.map(&:to_s)
    a_file = File.expand_path 'files/answers'
    File.open(a_file, "w") do |line|
      values.each { |i| line.puts i }
    end
    a_file
  end

end