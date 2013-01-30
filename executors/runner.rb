require 'open3'
require_relative './runnable.rb'

class Runner
  def initialize(runnable, limits = {})
    @runnable, @limits = runnable, limits
  end

  def run(limits = {})
    limits = @limits.merge limits
    out, err, status = run_with_limits limits

    Status.new out, err, status
  end

  private

  def run_with_limits(limits = @limits)
    Dir.chdir @runnable.path do
      Open3.capture3 @runnable.command
    end
  end

  class Status
    attr_reader :output, :error, :exitcode

    def initialize(output, error, status)
      @output, @error = output, error
      @exitcode = status.exitstatus
    end
  end
end
