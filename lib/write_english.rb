class WriteEnglish
  attr_reader :file_path,
              :night_reader,
              :file

  def initialize(file_path, night_reader)
    @file_path = file_path
    @night_reader = night_reader
    @file = night_reader.reader_contents
    # write_file(sanitize_file(file))
  end
end