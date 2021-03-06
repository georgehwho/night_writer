require_relative 'read_braille'
require_relative 'write_english'

class NightReader
  attr_reader :input,
              :output

  def initialize
    @input = ReadBraille.new(ARGV[0], self)
    @output = WriteEnglish.new(ARGV[1], self)
    puts confirmation
  end

  def confirmation
    "Created '#{output.file_path}' containing #{input.characters} characters"
  end

  def reader_contents
    input.file
  end
end

NightReader.new