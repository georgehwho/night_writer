class ReadFile
  attr_reader :file_path,
              :file

  def initialize(file_path)
    @file_path = file_path
    parse_file
  end

  def parse_file
    file_path.nil? ? @file = '' : @file = File.read(file_path)
  end

  def characters
    file.delete("\n").size
  end
end