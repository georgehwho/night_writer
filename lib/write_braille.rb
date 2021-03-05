require_relative 'braille'

class WriteBraille
  include Braille

  attr_reader :file_path,
              :night_writer,
              :file

  def initialize(file_path, night_writer)
    @file_path = file_path
    @night_writer = night_writer
    @file = sanitize_file(night_writer.reader_contents)
    write_file
  end

  def sanitize_file(input)
    input.downcase.delete("\n").chars
  end

  def convert_to_braille(input = file)
    array_of_braille = input.map { |char| to_braille[char] }

    array_of_braille.reduce([[], [], []]) do |memo, braille|
      memo.each_with_index { |arr, index| arr << braille[index] }
    end
  end

  def write_file
    return 'no file path given' if file_path.nil?
    File.delete(file_path) if File.exist?(file_path)
    File.open(file_path, "a") { |f| f.puts "#{file}" }
  end
end