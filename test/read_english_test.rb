require_relative 'test_helper'
require './lib/read_english'

class ReadEnglishTest < Minitest::Test
  def test_it_exists
    night_writer = mock
    reader = ReadEnglish.new('message.txt', night_writer)

    assert_instance_of ReadEnglish, reader
  end

  def test_it_has_readable_attributes
    night_writer = mock
    reader = ReadEnglish.new('message.txt', night_writer)

    assert_equal 'message.txt', reader.file_path
  end

  def test_it_can_parse_a_file
    night_writer = mock
    reader = ReadEnglish.new('message.txt', night_writer)

    assert_equal "lineone\nlinetwo\nlinethree", reader.parse_file
    assert_equal "lineone\nlinetwo\nlinethree", reader.file
  end

  def test_it_can_find_the_number_of_characters_in_the_string
    night_writer = mock
    reader = ReadEnglish.new('message.txt', night_writer)

    assert_equal 23, reader.characters
  end
end