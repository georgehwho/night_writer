class FileManager
  attr_reader :read,
              :write,
              :file

  def initialize(file_path, file_path_2)
    @read = file_path
    @write = file_path_2
    parse_file
  end

  def parse_file
    read.nil? ? @file = '' : @file = File.read(read)
  end

  def write_file(input)
    return 'no file path given' if write.nil?
    File.delete(write) if File.exist?(write)
    input.each do |row|
      File.open(write, "a") { |f| f.puts "#{row.class == String ? row : row.join}" }
    end
  end

  def characters
    file.delete("\n").size
  end
end