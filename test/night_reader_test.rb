require_relative 'test_helper'
require './lib/night_reader'
require './lib/file_manager'
require './lib/write_english'

class NightReaderTest < Minitest::Test
  def test_it_exists
    night_reader = NightReader.new

    assert_instance_of NightReader, night_reader
  end

  def test_it_has_readable_attributes
    night_reader = NightReader.new

    assert_instance_of FileManager, night_reader.file_manager
    assert_instance_of WriteEnglish, night_reader.translator
  end

  def test_it_can_print_a_confirmation_message
    night_reader = NightReader.new

    expected = "Created '' containing 0 characters"
    assert_equal expected, night_reader.confirmation
  end

  def test_can_know_reader_contents
    # skip
    night_reader = NightReader.new
    reader = FileManager.new('./test/txt_files/nw_message.txt', "./test/txt_files/nw_message_write.txt")

    night_reader.stubs(:file_manager).returns(reader)

    expected = "lineone\nlinetwo\nlinethree"
    assert_equal expected, night_reader.reader_contents
  end
end