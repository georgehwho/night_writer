require_relative 'braille'

class WriteEnglish
  include Braille

  attr_reader :file_path,
              :night_reader,
              :file

  def initialize(file_path, night_reader)
    @file_path = file_path
    @night_reader = night_reader
    @file = night_reader.reader_contents
    # write_file(sanitize_file(file))
  end

  def write_file(input) ### get back to this
    return 'no file path given' if file_path.nil?
    File.delete(file_path) if File.exist?(file_path)
    input.each do |row|
      File.open(file_path, "a") { |f| f.puts "#{row.join}" }
    end
  end

  def file_to_rows(string = file)
    chars = string.delete("\n").split('')
    chars.each_slice(chars.size/3).to_a
  end
end