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
    # skip
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h
    writer = WriteEnglish.new('original_message.txt', night_reader)

    writer.write_file(['h'])

    assert_equal "h\n", File.read('original_message.txt')
  end

  def test_it_can_sanitize_a_file
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h
    writer = WriteEnglish.new('original_message.txt', night_reader)

    assert_equal ['h'], writer.sanitize_file
    fourty_one_a = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n..\n"
    assert_equal ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "a"], writer.sanitize_file(fourty_one_a)
  end

  def test_it_can_convert_to_english
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h
    writer = WriteEnglish.new('original_message.txt', night_reader)

    assert_equal 'h', writer.to_english[['0', '.', '0', '0', '.', '.']]
  end

  def test_it_can_go_from_file_to_rows
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h
    writer = WriteEnglish.new('original_message.txt', night_reader)

    assert_equal [["0", '.'], ["0", "0"], ['.', '.']], writer.file_to_rows("0.\n00\n..\n")
    assert_equal [["0", '.', '.', '.'], ["0", "0", '.', '.'], ['.', '.', '.', '.']], writer.file_to_rows("0...\n00..\n....\n")

    edge_case_rows_test = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n..\n"
    assert_equal 6, writer.file_to_rows(edge_case_rows_test).size
  end

  def test_it_can_make_multi_rows_into_three_rows
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h
    writer = WriteEnglish.new('original_message.txt', night_reader)

    test_case = [
      ['.','.','u'],['.','.','u'],['.','.','u'],
      ['x','x'],['y','y'],['z','z'],
      ['.','.'],['.','.'],['.','.'],
    ]
    expected = [
      [".", ".", "u", "x", "x", ".", "."],
      [".", ".", "u", "y", "y", ".", "."],
      [".", ".", "u", "z", "z", ".", "."]
    ]
    assert_equal expected, writer.multi_rows_to_three_rows(test_case)
  end

  def test_it_can_go_from_rows_to_braille
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h
    writer = WriteEnglish.new('original_message.txt', night_reader)

    expected = [["0", ".", "0", "0", ".", "."], [".", ".", ".", ".", ".", "."]]
    assert_equal expected, writer.rows_to_braille([["0", '.', '.', '.'], ["0", "0", '.', '.'], ['.', '.', '.', '.']])
    big_expected = [["0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", "."], [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."], ["0", "."], [".", "."], [".", "."] ]
    assert_equal 41, writer.rows_to_braille(writer.multi_rows_to_three_rows(big_expected)).size
  end

  def test_it_can_convert_braille_strings_to_english
    night_reader = mock
    night_reader.stubs(:reader_contents).returns("0.\n00\n..\n") # this is h
    writer = WriteEnglish.new('original_message.txt', night_reader)

    assert_equal 'h ', writer.convert_to_english([["0", ".", "0", "0", ".", "."], [".", ".", ".", ".", ".", "."]])
  end
end