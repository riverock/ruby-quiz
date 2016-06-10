class FileHandle
  attr_accessor :file, :vals

  def initialize(file, vals=[])
    @file = file
    @vals = vals
  end


  def read
    words = []

    words_file = File.open(file, 'r') 
    words_file.each_line { |word| words << word.strip }
    words_file.close

    words
  end


  def write
    File.open(file, 'w') { |file| file.write(vals.join("\n")) }
  end
end
