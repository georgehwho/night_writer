require_relative 'test_helper'

class WriteBrailleTest < Minitest::Test
  def test_it_exists
    night_writer = mock
    writer = WriteBraille.new('braille.txt', night_writer)
    assert_instance_of WriteBraille, writer
  end


end