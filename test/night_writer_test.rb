require_relative 'test_helper'
require './lib/night_writer'
require './lib/read_english'
require './lib/write_braille'

class NightWriterTest < Minitest::Test
  def test_it_exists

    night_writer = NightWriter.new
    assert_instance_of NightWriter, night_writer
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

  def test_it_can_print_a_confirmation_message
    night_writer = NightWriter.new
    reader = ReadEnglish.new('message.txt', night_writer)
    writer = WriteBraille.new('braille.txt', night_writer)

    night_writer.stubs(:input).returns(reader)
    night_writer.stubs(:output).returns(writer)

    expected = "Created 'braille.txt' containing 15 characters"
    assert_equal expected, night_writer.confirmation
  end

  def test_can_know_reader_contents
    night_writer = NightWriter.new
    reader = ReadEnglish.new('message.txt', night_writer)
    writer = WriteBraille.new('braille.txt', night_writer)

    night_writer.stubs(:input).returns(reader)
    night_writer.stubs(:output).returns(writer)

    expected = "line1\nline2\nline3"
    assert_equal expected, night_writer.reader_contents
  end
end