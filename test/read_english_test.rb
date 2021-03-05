require_relative 'test_helper'

class ReadEnglishTest < Minitest::Test
  def test_it_exists
    reader = ReadEnglish.new('message.txt')
    assert_instance_of ReadEnglish, reader
  end

end