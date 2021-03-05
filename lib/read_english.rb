class ReadEnglish
  attr_reader :file_path,
              :night_writer,
              :file

  def initialize(file_path, night_writer)
    @file_path = file_path
    @night_writer = night_writer
    parse_file
  end

  def parse_file
    file_path.nil? ? @file = '' : @file = File.read(file_path)
  end
end