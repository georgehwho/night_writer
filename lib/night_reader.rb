require_relative 'file_manager'
require_relative 'write_english'

class NightReader
  attr_reader :file_manager,
              :translator

  def initialize
    @file_manager = FileManager.new(ARGV[0], ARGV[1])
    @translator = WriteEnglish.new
    puts confirmation
    write_file
  end

  def write_file
    file_manager.write_file(sanitize_file)
  end

  def sanitize_file
    translator.sanitize_file(reader_contents)
  end

  def confirmation
    "Created '#{file_manager.write}' containing #{file_manager.characters / 6} characters"
  end

  def reader_contents
    file_manager.file
  end
end

NightReader.new