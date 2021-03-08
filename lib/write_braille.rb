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
    write_file(sanitize_file(file))
  end

  def write_file(input)
    return 'no file path given' if file_path.nil?
    File.delete(file_path) if File.exist?(file_path)
    input.each do |row|
      File.open(file_path, "a") { |f| f.puts "#{row.join}" }
    end
  end

  def sanitize_file(string = file)
    chars = string.delete("\n").chars
    arr_braille = convert_to_braille(chars)
    rows = braille_to_rows(arr_braille)
    check_more_than_80_chars(rows)
  end

  def convert_to_braille(chars)
    chars.each_with_index.map do |char, index|
      if char == char.upcase && ![" ", "!", "'", ",", "-", ".", "?"].include?(char)
        char = to_braille['capitalize'] + to_braille[char.downcase]
      else
        to_braille[char]
      end
    end
  end

  def braille_to_rows(array_of_braille)
    array_of_braille.reduce([[], [], []]) do |memo, braille|
      if braille.size > 3
        memo.each_with_index { |arr, index| arr << braille[index] }
        memo.each_with_index { |arr, index| arr << braille[index+3] }
      else
        memo.each_with_index { |arr, index| arr << braille[index] }
      end
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
end