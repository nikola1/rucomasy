require 'open3'

class Runner
  attr_accessor :limits

  LIMITS_ALIASES = { memory: :rlimit_as,
                       time: :rlimit_cpu,
                      stack: :rlimit_stack }

  def initialize(runnable, limits = {})
    @runnable, @limits, @opts = runnable, limits
  end

  def run
    out, err, status = run_with_limits

    Status.new out, err, status
  end

  def add_limits(limits = {})
    @limits.merge! limits
    self
  end

  def remove_limits(limits = [])
    limits.each { |limit| @limits.delete limit }
    self
  end

  private

  def run_with_limits(limits = @limits)
    Dir.chdir @runnable.path do
      Open3.capture3 @runnable.command, parse_rlimits(limits)
    end
  end

  def parse_rlimits(limits)
    limits.each_with_object({}) do |(limit, value), result|
      result[LIMITS_ALIASES[limit]] = value unless LIMITS_ALIASES[limit].nil?
    end
  end

  class Status
    attr_reader :output, :error, :exitcode, :termsig, :stopsig

    ME_SIG_CODE = 6
    TL_SIG_CODE = 9
    ML_SIG_CODE = 11

    def initialize(output, error, status)
      @output, @error = output, error
      @exitcode       = status.exitstatus
      @termsig        = status.termsig
      @stopsig        = status.stopsig
    end

    def successful?
      @exitcode == 0
    end

    def reason
      if successful?
        :OK
      elsif @termsig == TL_SIG_CODE
        :TLE
      elsif @termsig == ML_SIG_CODE
        :MLE
      elsif @termsig == ME_SIG_CODE
        :ME
      elsif @exitcode != 0 && @exitcode != nil
        :NRC
      else
        :RE
      end
    end
  end
end
