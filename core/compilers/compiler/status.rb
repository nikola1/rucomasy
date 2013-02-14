module Compiler
  class Status
    attr_reader :output, :error, :success

    def initialize(output, error, status)
      @output, @error = output, error
      @success = status.success?
    end
  end
end