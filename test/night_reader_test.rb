require_relative 'test_helper'
require './lib/night_reader'
require './lib/read_braille'
require './lib/write_english'

class NightReaderTest < Minitest::Test
  def test_it_exists
    night_reader = NightReader.new

    assert_instance_of NightReader, night_reader
  end

  def test_it_can_know_where_read_and_write_are
    night_reader = NightReader.new
    reader = ReadFile.new('./test/txt_files/nr_braille.txt')
    writer = WriteEnglish.new('original_message.txt', night_reader)

    night_reader.stubs(:input).returns(reader)
    night_reader.stubs(:output).returns(writer)

    assert_equal './test/txt_files/nr_braille.txt', night_reader.input.file_path
    assert_equal 'original_message.txt', night_reader.output.file_path
  end

  def test_it_can_print_a_confirmation_message
    night_reader = NightReader.new
    reader = ReadFile.new('./test/txt_files/nr_braille.txt')
    writer = WriteEnglish.new('original_message.txt', night_reader)

    night_reader.stubs(:input).returns(reader)
    night_reader.stubs(:output).returns(writer)

    expected = "Created 'original_message.txt' containing 15 characters"
    assert_equal expected, night_reader.confirmation
  end

  def test_can_know_reader_contents
    night_reader = NightReader.new
    reader = ReadFile.new('./test/txt_files/nr_braille.txt')
    writer = WriteEnglish.new('original_message.txt', night_reader)

    night_reader.stubs(:input).returns(reader)
    night_reader.stubs(:output).returns(writer)

    expected = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
    assert_equal expected, night_reader.reader_contents
  end
end