require_relative 'test_helper'
require './lib/write_english'

class WriteEnglishTest < Minitest::Test
  def test_it_exists
    writer = WriteEnglish.new

    assert_instance_of WriteEnglish, writer
  end

  def test_it_can_sanitize_a_file
    writer = WriteEnglish.new

    assert_equal ['h'], writer.sanitize_file("0.\n00\n..\n")

    fourty_one_a = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n..\n"
    assert_equal ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "a"], writer.sanitize_file(fourty_one_a)
  end

  def test_it_can_convert_to_english
    writer = WriteEnglish.new

    assert_equal 'h', writer.to_english[['0', '.', '0', '0', '.', '.']]
  end

  def test_it_can_go_from_file_to_rows
    writer = WriteEnglish.new

    assert_equal [["0", '.'], ["0", "0"], ['.', '.']], writer.file_to_rows("0.\n00\n..\n")
    assert_equal [["0", '.', '.', '.'], ["0", "0", '.', '.'], ['.', '.', '.', '.']], writer.file_to_rows("0...\n00..\n....\n")

    fourty_one_a = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n..\n"
    assert_equal 6, writer.file_to_rows(fourty_one_a).size
  end

  def test_it_can_make_multi_rows_into_three_rows
    writer = WriteEnglish.new

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
    writer = WriteEnglish.new

    expected = [["0", ".", "0", "0", ".", "."], [".", ".", ".", ".", ".", "."]]
    assert_equal expected, writer.rows_to_braille([["0", '.', '.', '.'], ["0", "0", '.', '.'], ['.', '.', '.', '.']])

    many_a_expected = [["0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", ".", "0", "."],
                    [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                    [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                    ["0", "."],
                    [".", "."],
                    [".", "."] ]
    assert_equal 41, writer.rows_to_braille(writer.multi_rows_to_three_rows(many_a_expected)).size
  end

  def test_it_can_convert_braille_strings_to_english
    writer = WriteEnglish.new

    expected = [["0", ".", "0", "0", ".", "."],
                [".", ".", ".", ".", ".", "."]]
    assert_equal 'h ', writer.convert_to_english(expected)

    expected_two = [[".", ".", "0", "0", "0", "."],
                    [".", ".", ".", ".", "0", "."],
                    [".", ".", "0", ".", ".", "."],
                    [".", ".", ".", ".", "0", "0"],
                    [".", ".", "0", "0", ".", "0"],
                    [".", ".", "0", ".", "0", "0"]]
    assert_equal "!',-.?", writer.convert_to_english(expected_two)
  end

  def test_it_can_convert_all_chars_to_english
    writer = WriteEnglish.new

    all_char_braille = "..............0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000...0...0...00..\n..00..0...000...0....0.00.00000.00..0....0.00.00000.00..0.00...0.0......0.......\n..0.0...00.000....................0.0.0.0.0.0.0.0.0.0.0000.0000000.0...0...0...0\n00..0...00..00..0....0...0..0...0...00..00..0...00..00..0....0...0..0...0....0..\n.0...0..0...00..00..0...00......0........0...0..0...00..00..0...00......0...00..\n...0...0...0...0...0...0...00..00..00..00..00..00..00..00..00..00..000.000.0.0.0\n00..00..0.\n.....0...0\n00.000.000"
    expected = [" !',-.?abcdefghijklmnopqrstuvwxyzABCDEFG", "HIJKLMNOPQRSTUVWXYZ"]
    assert_equal expected, writer.sanitize_file(all_char_braille)
  end
end
