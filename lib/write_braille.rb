require_relative 'braille'

class WriteBraille
  include Braille

  attr_reader :file_path,
              :night_writer,
              :file

  def initialize(file_path, night_writer)
    @file_path = file_path
    @night_writer = night_writer
    @file = night_writer.reader_contents
  end


end