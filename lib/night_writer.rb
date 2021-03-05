class NightWriter
  attr_reader :input,
              :output
  def initialize
    @input = ReadEnglish.new(ARGV[0])
    @output = ARGV[1]
  end

  def confirmation
    "Created '#{write}' containing #{} characters"
  end

  def read_input
    File.read(input)
    input.read_input
  end
end