class Runnable
  attr_reader :command, :files, :parameters

  def initialize(command, files = [], parameters = [])
    @command, @files, @parameters = command, files, parameters
  end

  class Status
    attr_reader :output, :error, :exitcode

    def initialize(output, error, status)
      @output, @error = output, error
      @exitcode = status.exitstatus
    end
  end
end