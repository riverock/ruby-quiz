require 'minitest/autorun'
require_relative '../engine'

class TestEngine < MiniTest::Unit::TestCase
  @@file = 'test/files/list'

  def setup
    @test = Engine.new @@file
  end

  def test_convert_file_to_array
    output = Engine.convert_file_to_array(@@file)
    assert_equal %w{ arrows carrots give me }, output
  end

  def test_initialize
    assert_equal %w{arrows carrots give}, @test.words
  end

  def test_steps_to_check
    assert_equal 4, @test.steps_to_check
  end

  def test_eliminate
    assert @test.eliminate('arro')
  end

  def test_process
    expected = { carr: 'carrots',
                 give: 'give',
                 rots: 'carrots',
                 rows: 'arrows',
                 rrot: 'carrots',
                 rrow: 'arrows' }.sort.to_h
    assert_equal expected, @test.process.sort.to_h
  end

end