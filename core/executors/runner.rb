require 'open3'
require 'immutable_struct'

class Runner
  def initialize(runnable, limits = {}, opts = {})
    @runnable, @limits, @opts = runnable, limits, opts
  end

  def run
    out, err, status = run_with_limits

    Status.new out, err, status.exitstatus, self
  end

  def limit(limits = {})
    @limits |= limits
    self
  end

  private

  def run_with_limits(limits = @limits)
    Dir.chdir @runnable.path do
      Open3.capture3 @runnable.command, @opts
    end
  end

  Status = ImmutableStruct.new(:output, :error, :exitcode, :runner)
end
