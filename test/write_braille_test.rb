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
    assert_equal 'hello', writer.file
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

    expected = [[0, ".", 0, ".", 0, ".", 0, ".", 0, "."],
                [0, 0, ".", 0, 0, ".", 0, ".", ".", 0],
                [".", ".", ".", ".", 0, ".", 0, ".", 0, "."]]
    assert_equal expected, writer.sanitize_file
  end

  def test_braille_module_works
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('hello')

    writer = WriteBraille.new('braille.txt', night_writer)

    assert_equal [[0, "."], [".", "."], [".", "."]], writer.to_braille['a']
  end

  def test_can_convert_a_single_letter
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('h')

    writer = WriteBraille.new('braille.txt', night_writer)

    expected = [[[0, "."], [0, 0], [".", "."]]]
    assert_equal expected, writer.convert_to_braille(['h'])
    assert_equal  "0.\n00\n..\n", File.read('braille.txt')
  end

  def test_can_convert_symbols
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('h')

    writer = WriteBraille.new('braille.txt', night_writer)
    expected = [[[".", "."], [0, 0], [0, "."]], [[".", "."], [".", "."], [0, "."]], [[".", "."], [0, "."], [".", "."]], [[".", "."], [".", "."], [0, 0]], [[".", "."], [0, 0], [".", 0]], [[".", "."], [0, "."], [0, 0]]]
    assert_equal expected, writer.convert_to_braille(%w[! ' , - . ?])
  end

  def test_it_can_check_if_a_row_has_more_than_80_chars
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('h')

    writer = WriteBraille.new('braille.txt', night_writer)

    array = ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaax".split(''),
            [],
            []]
    expected = ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa".split(''),
               [],
               [],
               ['x']]
    assert_equal expected, writer.check_more_than_80_chars(array)
  end

  def test_can_convert_a_file_to_rows_of_braille
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('he')

    writer = WriteBraille.new('braille.txt', night_writer)

    expected = [[0, ".", 0, "."],
                [0, 0, ".", 0],
                [".", ".", ".", "."]]
    assert_equal expected, writer.braille_to_rows([[[0, "."], [0, 0], [".", "."]], [[0, "."], [".", 0], [".", "."]]])
  end

  def test_it_can_convert_82_postions_to_two_lines
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')

    writer = WriteBraille.new('./test/txt_files/82_test_positions.txt', night_writer)
    assert_equal File.read('./test/txt_files/82_positions.txt'), File.read('./test/txt_files/82_test_positions.txt')
  end

  def test_it_can_convert_to_capital
    night_writer = mock
    night_writer.stubs(:reader_contents).returns('h')

    writer = WriteBraille.new('braille.txt', night_writer)

    expected = [[[".", "."], [".", "."], [".", 0], [0, "."], [0, 0], [".", "."]]]
    assert_equal expected, writer.convert_to_braille(['H'])
  end

  def test_it_can_convert_all_letters
    # skip
    night_writer = mock
    night_writer.stubs(:reader_contents).returns(" !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

    writer = WriteBraille.new('./test/txt_files/all_chars_test.txt', night_writer)
    assert_equal File.read('./test/txt_files/all_chars.txt'), File.read('./test/txt_files/all_chars_test.txt')
  end
end