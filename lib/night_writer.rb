class NightWriter
  attr_reader :input,
              :output
  def initialize
    @input = ReadEnglish.new(ARGV[0], self)
    @output = WriteBraille.new(ARGV[1], self)
  end

  def confirmation
    "Created '#{write}' containing #{} characters"
  end

  def read_input
    input.read_input
  end
end