
require_relative "../interrogate_dictionary"
require "test/unit"

class TestInterrogateDictionary < Test::Unit::TestCase
  def test_sanitize_line
    line = "dictionary\n"
    sanitized_line = "dictionary"
    term = InterrogateDictionary.new.output_header_line_and_sanitize_line(line)

    assert_equal term, sanitized_line
  end

  def test_term_length
    terms = { good: "good", bad: "bad" }
    assert_false terms[:good].length < InterrogateDictionary::VALUES[:min_term_length]
    assert_true terms[:bad].length < InterrogateDictionary::VALUES[:min_term_length]
  end

  def test_slice_term
    input = {
      term: 'differential',
      slice_results: ['diff', 'iffe', 'ffer', 'fere', 'eren', 'rent', 'enti', 'ntia', 'tial']
    }
    term_results = InterrogateDictionary.new.slice_term(input[:term])
    assert_equal input[:slice_results], term_results
  end

  # there should be about 5 or more tests in this suite but I was having a little trouble using
  # attr_reader and such in the tests. I think due to the way I set it up to run from the command
  # line and keeping variables as private as possible. I think those are good habits but I got a
  # little too focused on that. I'm just out of time now and wanted to submit something ASAP. Rest
  # assured, I'll figure it out and get it in there regardless of the outcome. 
end
