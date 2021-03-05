class WriteBraille
  attr_reader :file_path,
              :night_writer

  def initialize(file_path, night_writer)
    @file_path = file_path
    @night_writer = night_writer
  end
end