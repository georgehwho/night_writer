require_relative 'read_english'
require_relative 'write_braille'

class NightWriter
  attr_reader :input,
              :output
  def initialize
    @input = ReadEnglish.new(ARGV[0], self)
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