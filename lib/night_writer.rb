require_relative 'read_file'
require_relative 'write_braille'

class NightWriter
  attr_reader :input,
              :output

  def initialize
    @input = ReadFile.new(ARGV[0])
    @output = WriteBraille.new(ARGV[1], self)
    puts confirmation
  end

  def confirmation
    "Created '#{output.file_path}' containing #{input.characters} characters"
  end

  def reader_contents
    input.file
  end
end

NightWriter.new