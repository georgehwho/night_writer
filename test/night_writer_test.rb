require_relative 'test_helper'
require './lib/night_writer'
require './lib/file_manager'
require './lib/write_braille'

class NightWriterTest < Minitest::Test
  def test_it_exists
    night_writer = NightWriter.new

    assert_instance_of NightWriter, night_writer
  end

  def test_it_has_readable_attributes
    night_writer = NightWriter.new

    assert_instance_of FileManager, night_writer.file_manager
    assert_instance_of WriteBraille, night_writer.translator
  end

  def test_it_can_print_a_confirmation_message
    # skip
    night_writer = NightWriter.new

    expected = "Created '' containing 0 characters"
    assert_equal expected, night_writer.confirmation
  end

  def test_can_know_reader_contents
    # skip
    night_writer = NightWriter.new
    reader = FileManager.new('./test/txt_files/nw_message.txt', "./test/txt_files/nw_message_write.txt")

    night_writer.stubs(:file_manager).returns(reader)

    expected = "lineone\nlinetwo\nlinethree"
    assert_equal expected, night_writer.reader_contents
  end

  def test_it_can_write_to_a_file
    night_writer = NightWriter.new
    reader = FileManager.new('./test/txt_files/nw_message.txt', "./test/txt_files/nw_message_write.txt")

    night_writer.stubs(:file_manager).returns(reader)
    night_writer.stubs(:sanitize_file).returns(['h','e','l','l','o'])
    assert_equal "h\ne\nl\nl\no\n", File.read(night_writer.file_manager.write)
  end

  def test_it_can_sanitize_a_file
    night_writer = NightWriter.new

    night_writer.stubs(:reader_contents).returns('hello')
    expected = [[0, ".", 0, ".", 0, ".", 0, ".", 0, "."],
                [0, 0, ".", 0, 0, ".", 0, ".", ".", 0],
                [".", ".", ".", ".", 0, ".", 0, ".", 0, "."]]
    assert_equal expected, night_writer.sanitize_file
  end
end