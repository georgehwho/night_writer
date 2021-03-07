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
    string.split("\n").map { |row| row.split('') }
  end

  def multi_rows_to_three_rows(multi_rows)
    while multi_rows.size > 3
      multi_rows.each_with_index.map do |row, index|
        if index > 2
          multi_rows[index-3] << row.flatten
          multi_rows[index] = []
        end
      end
      multi_rows.reject! { |row| row.empty? }
    end
    multi_rows.map(&:flatten)
  end

  def rows_to_braille(rows)
    holder = []
    rows.each_with_index.map do |row, index|
      (row.size/2).times do |num|
        holder[num] = [] if holder[num].nil?
        holder[num] << row.shift << row.shift
      end
    end
    holder
  end
end