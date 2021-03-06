require_relative 'test_helper'
require './lib/write_english'

class WriteEnglishTest < Minitest::Test
  def test_it_exists
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h

    writer = WriteEnglish.new('original_message.txt', night_reader)

    assert_instance_of WriteEnglish, writer
  end

  def test_it_has_readable_attributes
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h

    writer = WriteEnglish.new('original_message.txt', night_reader)

    assert_equal 'original_message.txt', writer.file_path
    assert_equal "0.\n00\n..\n", writer.file
  end

  def test_it_can_write_to_a_file ## get back to this
    skip
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h
    writer = WriteEnglish.new('original_message.txt', night_reader)

    writer.write_file([[0, "."], [".", "."], [".", "."]])

    assert_equal "0.\n..\n..\n", File.read('braille.txt')
  end

  def test_it_can_convert_to_english
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h
    writer = WriteEnglish.new('original_message.txt', night_reader)

    assert_equal 'h', writer.to_english[[['0', '.'], ['0', '0'], ['.', '.']]]
  end

  def test_it_can_go_from_file_to_rows
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h
    writer = WriteEnglish.new('original_message.txt', night_reader)

    assert_equal [["0", '.'], ["0", "0"], ['.', '.']], writer.file_to_rows("0.\n00\n..\n")
  end
end