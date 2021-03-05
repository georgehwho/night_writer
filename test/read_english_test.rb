require_relative 'test_helper'

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

    assert_equal "line1\nline2\nline3", reader.parse_file
    assert_equal "line1\nline2\nline3", reader.file
  end

end