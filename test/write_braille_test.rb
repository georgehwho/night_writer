require_relative 'test_helper'

class WriteBrailleTest < Minitest::Test
  def test_it_exists
    writer = WriteBraille.new('braille.txt')
    assert_instance_of WriteBraille, writer
  end

end