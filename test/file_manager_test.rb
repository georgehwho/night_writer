require_relative 'test_helper'
require './lib/file_manager'

class FileManagerTest < Minitest::Test
  def test_it_exists
    manager = FileManager.new('./test/txt_files/nw_message.txt', "./test/txt_files/nw_message_write.txt")

    assert_instance_of FileManager, manager
  end

  def test_it_has_readable_attributes
    manager = FileManager.new('./test/txt_files/nw_message.txt', "./test/txt_files/nw_message_write.txt")

    assert_equal './test/txt_files/nw_message.txt', manager.read
    assert_equal  "./test/txt_files/nw_message_write.txt", manager.write
  end

  def test_it_can_parse_a_file
    manager = FileManager.new('./test/txt_files/nw_message.txt', "./test/txt_files/nw_message_write.txt")

    assert_equal "lineone\nlinetwo\nlinethree", manager.parse_file
    assert_equal "lineone\nlinetwo\nlinethree", manager.file
  end

  def test_it_can_find_the_number_of_characters_in_the_string
    manager = FileManager.new('./test/txt_files/nw_message.txt', "./test/txt_files/nw_message_write.txt")

    assert_equal 23, manager.characters
  end

  def test_it_can_write_to_a_file
    manager = FileManager.new('./test/txt_files/nw_message.txt', "./test/txt_files/nw_message_write.txt")

    manager.write_file(['h','e','l','l','o'])
    assert_equal "h\ne\nl\nl\no\n", File.read(manager.write)
  end
end