require_relative 'test_helper'
require './lib/read_file'

class ReadFileTest < Minitest::Test
  def test_it_exists
    reader = ReadFile.new('./test/txt_files/nw_message.txt')

    assert_instance_of ReadFile, reader
  end

  def test_it_has_readable_attributes
    reader = ReadFile.new('./test/txt_files/nw_message.txt')

    assert_equal './test/txt_files/nw_message.txt', reader.file_path
  end

  def test_it_can_parse_a_file
    reader = ReadFile.new('./test/txt_files/nw_message.txt')

    assert_equal "lineone\nlinetwo\nlinethree", reader.parse_file
    assert_equal "lineone\nlinetwo\nlinethree", reader.file
  end

  def test_it_can_find_the_number_of_characters_in_the_string
    reader = ReadFile.new('./test/txt_files/nw_message.txt')

    assert_equal 23, reader.characters
  end
end