require 'minitest/autorun'
require_relative '../../dict'

class TestDict < Minitest::Test

    def test_dir_pwd
      assert(Dict::ROOT_PATH, Dir.pwd)
    end

    def setup
      @dict = Dict.new(file_w: "#{Dict::ROOT_PATH}/test/minitest/files/words_test.txt",
                       file_q: "#{Dict::ROOT_PATH}/test/minitest/files/questions_test.txt",
                       file_a: "#{Dict::ROOT_PATH}/test/minitest/files/answers_test.txt",
                       do_puts: false)
    end

    def test_that_files_are_initialized
      @dict.initialize_files
      assert File.exist?(@dict.file_q)
      assert File.exist?(@dict.file_a)
    end

    def test_that_words_less_than_four_letters_are_filtered_out_test
      @dict.filter_words(@dict.all_words)
      assert_equal(@dict.count_words(@dict.filtered_words), 3)
    end


    def test_that_run_creates_correct_all_questions_hash_test
      @dict.run

      assert(@dict.all_questions_hash, 
              {"arro"=>{"word"=>["arrows", "carrots"], "count"=>2}, 
               "rrow"=>{"word"=>["arrows"], "count"=>1},
               "rows"=>{"word"=>["arrows"], "count"=>1}, 
               "carr"=>{"word"=>["carrots"], "count"=>1}, 
               "rrot"=>{"word"=>["carrots"], "count"=>1}, 
               "rots"=>{"word"=>["carrots"], "count"=>1}, 
               "give"=>{"word"=>["give"], "count"=>1}})
    end

end