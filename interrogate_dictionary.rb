# @author: Dan Yachcik
# April 19, 2021

FILE_PATHS = {
  answers: 'output_files/answers.txt',
  log: 'output_files/log.txt',
  questions: 'output_files/questions.txt',
  test: 'input_files/test_file.txt'
}
VALUES = { dupe_count: 1, min_term_length: 4, term_index_increment: 3, trimmed_term_value: 1 }

class InterrogateDictionary
  def initialize
    @all_sliced_terms = {}
    @log = File.open(FILE_PATHS[:log], "w")
    @start_time = Time.now
    check_args
  end

  def check_args
    ARGV.empty? ? @path_to_input_file = FILE_PATHS[:test] : @path_to_input_file = ARGV[0]
  end

  def main
    iterate_dictionary_and_split_terms
    find_dictionary_term_for_term_portion_and_build_results_hash
    output_final_results
  end

  def output_header_line_and_sanitize_line(line)
    term = sanitize_line(line)
    @log.write("----------     #{term}     ----------\n")
    term
  end

  def slice_term(term)
    term_values = []
    term.chars.each_with_index do |c, i|
      max_index = i + VALUES[:term_index_increment]
      term_values << term.slice(i..max_index)
      break if max_index == term.length.to_i - VALUES[:trimmed_term_value]
    end
      term_values
  end

  private

  def calculate_run_time
    (Time.now - @start_time)
  end

  def find_and_eliminate_duplicates
    questions = @all_sliced_terms.values.flatten
    questions.reject { |q| questions.count(q) > VALUES[:dupe_count] }.uniq
  end

  def find_dictionary_term_for_term_portion_and_build_results_hash
    @results_hash = {}
    find_and_eliminate_duplicates.sort.each do |q|
      @all_sliced_terms.each do |term, results|
        next unless term.include?(q)
        @results_hash[q] = term
      end
    end
  end

  def iterate_dictionary_and_split_terms
    File.open(@path_to_input_file).each do |line|
      term = output_header_line_and_sanitize_line(line)
      next if term.length < VALUES[:min_term_length]
      @all_sliced_terms[term] = slice_term(term)
    end
  end

  def output_final_results
    write_to_output_files
    @log.write("Total runtime: #{calculate_run_time}\n")
    @log.write("Total results count: #{@all_sliced_terms.count}\n")
    @log.close
  end

  def sanitize_line(line)
    line.gsub!("\n", '')
  end

  def write_to_output_files
    answers = File.open(FILE_PATHS[:answers], "w")
    questions = File.open(FILE_PATHS[:questions], "w")
    @results_hash.each do |question, answer|
      answers.write(answer + "\n")
      questions.write(question + "\n")
    end
    answers.close
    questions.close
  end

  def all_sliced_terms
    @all_sliced_terms
  end
end

InterrogateDictionary.new.main
