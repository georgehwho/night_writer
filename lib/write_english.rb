require_relative 'braille'

class WriteEnglish
  include Braille

  def sanitize_file(string)
    rows = file_to_rows(string)
    three_rows = multi_rows_to_three_rows(rows)
    braille_rows = rows_to_braille(three_rows)
    english = convert_to_english(braille_rows)
    english.scan(/.{1,40}/)
  end

  def file_to_rows(string)
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

  def convert_to_english(array_of_braille)
    array_of_braille.each_with_index.map do |braille, index|
      if to_english[braille] == 'capitalize'
        array_of_braille.delete_at(index)
        to_english[array_of_braille[index]].upcase
      else
        to_english[braille]
      end
    end.join
  end
end