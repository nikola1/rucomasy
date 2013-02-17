class SimpleIOTestcase
  attr_reader :input, :output

  def initialize(input, output)
    @input, @output = File.absolute_path(input), File.absolute_path(output)
  end
end