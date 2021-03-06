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
    write_file(check_more_than_80_chars(convert_to_braille))
  end

  def sanitize_file(input)
    input.downcase.delete("\n").chars
  end

  def convert_to_braille(input = file)
    array_of_braille = input.map { |char| to_braille[char] }

    array_of_braille.reduce([[], [], []]) do |memo, braille|
      memo.each_with_index { |arr, index| arr << braille[index] }
    end.map(&:flatten)
  end

  def check_more_than_80_chars(rows)
    rows.each_with_index.map do |row, index|
      if row.length > 80
        rows[index+3] = row[80..-1]
        rows[index] = row[0..79]
      end
    end
    return rows
  end

  def write_file(input)
    return 'no file path given' if file_path.nil?
    File.delete(file_path) if File.exist?(file_path)
    input.each do |row|
      File.open(file_path, "a") { |f| f.puts "#{row.join}" }
    end
  end
end