SEEK_NUM = 4
require_relative 'extenders'

class Engine
  attr_accessor :words, :ref_hash

  class << self
    def convert_file_to_array file
      file_location = File.expand_path(file)
      content = File.open(file_location, 'r').read
      content.split("\n")
    end

    def run
      hash = Engine.new('words').process
      puts "* And now generating the the 'files' folder."
      hash.to_questions_file
      hash.to_answers_file
      puts "* Complete! *"
    end
  end

  def initialize file
    self.ref_hash = {}
    list = Engine.convert_file_to_array file
    self.words = list.conditioner
  end

  def steps_to_check
    (words.map(&:size).max - SEEK_NUM) + 1
  end

  def eliminate(current)
    found = 0
    words.each do |i|
      found += 1 if current && i.match(current)
    end
    found > 1
  end

  def process
    steps_to_check.times do |pass|
      calculate(pass)
    end
    ref_hash
  end

  private

  def calculate pass
    words.each do |i|
      current = i[pass, SEEK_NUM]
      print_status(pass, current)
      ref_hash[current.to_sym] = i if current&.size == SEEK_NUM && !eliminate(current)
    end
  end

  def print_status(pass_num, current)
    puts "Processing pass ##{pass_num}/#{steps_to_check}: #{current}"
  end

end