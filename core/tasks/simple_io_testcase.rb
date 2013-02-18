module Rucomasy
  class SimpleIOTestcase < Testcase
    attr_reader :input, :output

    def initialize(number = 0, input, output)
      super(number)
      @input, @output = File.absolute_path(input), File.absolute_path(output)
    end
  end
end