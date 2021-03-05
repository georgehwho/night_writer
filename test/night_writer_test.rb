require_relative 'test_helper'

class NightWriterTest < Minitest::Test
  def test_it_exists
    night_writer = NightWriter.new
  end

  def test_it_can_know_where_read_and_write_are
    night_writer = NightWriter.new
    reader = ReadEnglish.new('message.txt', night_writer)
    writer = WriteBraille.new('braille.txt', night_writer)

    night_writer.stubs(:input).returns(reader)
    night_writer.stubs(:output).returns(writer)

    assert_equal 'message.txt', night_writer.input.file_path
    assert_equal 'braille.txt', night_writer.output.file_path
  end

  def test_it_find_how_many_characters_are_in_a_file

  end
end