class SimpleIOTestcase
  attr_reader :input, :output

  def initialize(input, output)
    @input, @output = File.new(input), File.new(output)
  end
end