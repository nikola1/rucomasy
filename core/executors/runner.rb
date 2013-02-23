require 'open3'

module Rucomasy
  class Runner
    attr_accessor :options

    ALLOWED_OPTIONS = [:memory, :time, :stack, :stdin, :stdout, :stderr, :pwd,
      :no_input, :no_output, :no_error]

    OPTIONS_ALIASES = { memory: :rlimit_as, time: :rlimit_cpu,
      stack: :rlimit_stack, stdin: :in, stdout: :out, stderr: :err, pwd: :chdir }

    def initialize(runnable, options = {})
      @runnable, @options = runnable, options
    end

    def run(additional_options = {})
      out, err, status = run_with_options @options.merge additional_options

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
      filtered_options = options.reject do |option, value|
        not ALLOWED_OPTIONS.member?(option)
      end

      options.each do |option, value|
        unless OPTIONS_ALIASES[option].nil?
          filtered_options[OPTIONS_ALIASES[option]] = filtered_options.delete option
        end
      end
      filtered_options
    end

    class Status
      attr_reader :output, :error, :exitcode, :termsig, :stopsig, :time, :memory

      ME_SIG_CODE = 6
      TL_SIG_CODE = 9
      ML_SIG_CODE = 11

      def initialize(output, error, status)
        @output, @error = output, error
        @exitcode       = status.exitstatus
        @termsig        = status.termsig
        @stopsig        = status.stopsig
        # TODO:
        @time           = 0.0
        @memory         = 0.0
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

      opts[:in]  = FileHelper.create_runner_file unless opts[:in]
      opts[:out] = FileHelper.create_runner_file unless opts[:out]
      opts[:err] = FileHelper.create_runner_file unless opts[:err]
      opts[:in] = [opts[:in]]

      opts[:chdir] ||= pwd
      Process.spawn *cmd, opts

      pid, status = Process.wait2

      output = File.read opts[:out]
      error = File.read opts[:err]
      [output, error, status]
    end
  end
end