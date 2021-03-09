require_relative 'test_helper'
require './lib/write_braille'


class WriteBrailleTest < Minitest::Test
  def test_it_exists
    writer = WriteBraille.new()

    assert_instance_of WriteBraille, writer
  end

  def test_it_can_sanitize_a_file
    # skip
    writer = WriteBraille.new()

    expected = [[0, ".", 0, ".", 0, ".", 0, ".", 0, "."],
                [0, 0, ".", 0, 0, ".", 0, ".", ".", 0],
                [".", ".", ".", ".", 0, ".", 0, ".", 0, "."]]
    assert_equal expected, writer.sanitize_file('hello')
  end

  def test_braille_module_works
    # skip
    writer = WriteBraille.new()

    assert_equal [[0, "."], [".", "."], [".", "."]], writer.to_braille['a']
  end

  def test_can_convert_a_single_letter
    # skip
    writer = WriteBraille.new()

    expected = [[[0, "."], [0, 0], [".", "."]]]
    assert_equal expected, writer.convert_to_braille(['h'])
  end

  def test_can_convert_symbols
    # skip
    writer = WriteBraille.new()

    expected = [[[".", "."], [0, 0], [0, "."]], [[".", "."], [".", "."], [0, "."]], [[".", "."], [0, "."], [".", "."]], [[".", "."], [".", "."], [0, 0]], [[".", "."], [0, 0], [".", 0]], [[".", "."], [0, "."], [0, 0]]]
    assert_equal expected, writer.convert_to_braille(%w[! ' , - . ?])
  end

  def test_it_can_check_if_a_row_has_more_than_80_chars
    # skip
    writer = WriteBraille.new()

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
    # skip
    writer = WriteBraille.new()

    expected = [[0, ".", 0, "."],
                [0, 0, ".", 0],
                [".", ".", ".", "."]]
    assert_equal expected, writer.braille_to_rows([[[0, "."], [0, 0], [".", "."]], [[0, "."], [".", 0], [".", "."]]])
  end

  def test_it_can_convert_to_capital
    # skip
    writer = WriteBraille.new()

    expected = [[[".", "."], [".", "."], [".", 0], [0, "."], [0, 0], [".", "."]]]
    assert_equal expected, writer.convert_to_braille(['H'])
  end
end