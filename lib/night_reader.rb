require_relative 'read_file'
require_relative 'write_english'

class NightReader
  attr_reader :input,
              :output

  def initialize
    @input = ReadFile.new(ARGV[0])
    @output = WriteEnglish.new(ARGV[1], self)
    puts confirmation
  end

  def confirmation
    "Created '#{output.file_path}' containing #{input.characters / 2} characters"
  end

  def reader_contents
    input.file
  end
end

NightReader.new