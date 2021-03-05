require_relative 'test_helper'

class WriteBrailleTest < Minitest::Test
  def test_it_exists
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('hello')
    writer = WriteBraille.new('braille.txt', night_writer)

    assert_instance_of WriteBraille, writer
  end

  def test_it_has_readable_attributes
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('hello')
    writer = WriteBraille.new('braille.txt', night_writer)

    assert_equal 'braille.txt', writer.file_path
    assert_equal 'hello', writer.file
  end

  def test_braille_module_works
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('hello')
    writer = WriteBraille.new('braille.txt', night_writer)

    assert_equal [[0, "."], [".", "."], [".", "."]], writer.to_braille['a']
  end
end