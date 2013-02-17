require 'open3'

class Runner
  attr_accessor :options

  OPTIONS_ALIASES = { memory: :rlimit_as,
                        time: :rlimit_cpu,
                       stack: :rlimit_stack,
                       stdin: :in,
                      stdout: :out,
                      stderr: :err,
                         pwd: :chdir }

  def initialize(runnable, options = {})
    @runnable, @options = runnable, options
  end

  def run
    out, err, status = run_with_options

    Status.new out, err, status
  end

  def add_options(options = {})
    @options.merge! options
    self
  end

  def remove_options(options = [])
    options.each { |option| @options.delete option }
    self
  end

  private

  def run_with_options(options = @options)
    run_process @runnable.fullpath, @runnable.command, parse_options(options)
  end

  def parse_options(options)
    options.each_with_object({}) do |(option, value), result|
      result[OPTIONS_ALIASES[option]] = value unless OPTIONS_ALIASES[option].nil?
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

  private

  def run_process(pwd, *cmd)
    if Hash === cmd.last
      opts = cmd.pop.dup
    else
      opts = {}
    end

    input_file   = opts.delete(:in)
    output_file  = opts.delete(:out)
    error_file   = opts.delete(:err)

    opts[:chdir] ||= pwd
    opts[:stdin_data] = File.read input_file unless input_file.nil?

    output, error, status = Open3.capture3(*cmd, opts)

    File.write output_file, output unless output_file.nil?
    File.write error_file, error unless error_file.nil?

    [output, error, status]
  end
end
