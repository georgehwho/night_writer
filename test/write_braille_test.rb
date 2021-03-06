require_relative 'test_helper'
require './lib/write_braille'


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
  end

  def test_it_can_write_to_a_file
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('hello')
    writer = WriteBraille.new('braille.txt', night_writer)
    writer.write_file([[0, "."], [".", "."], [".", "."]])
    assert_equal "0.\n..\n..\n", File.read('braille.txt')
  end

  def test_it_can_sanitize_a_file
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('hello')
    writer = WriteBraille.new('braille.txt', night_writer)

    assert_equal ["h", "e", "l", "l", "o"], writer.file
  end

  def test_braille_module_works
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('hello')
    writer = WriteBraille.new('braille.txt', night_writer)

    assert_equal [[0, "."], [".", "."], [".", "."]], writer.to_braille['a']
  end

  def test_can_convert_a_file_to_braille
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('he')

    writer = WriteBraille.new('braille.txt', night_writer)

    expected = [[[0, "."], [0, "."]], [[0, 0], [".", 0]], [[".", "."], [".", "."]]]
    assert_equal expected, writer.convert_to_braille
  end
end