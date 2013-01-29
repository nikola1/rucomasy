require 'open3'
require_relative '../executors/runnable.rb'

class Compiler
  class << self
    def compile(source, destination, additional_files = [])
      before_compilation source, destination, additional_files

      compile_command = prepare_compile_command source, destination, additional_files
      status = Status.new *Open3.capture3(*compile_command)

      after_compilation source, destination, additional_files

      command = create_command source, destination, additional_files
      return status, Runnable.new(command, [destination] + additional_files)
    end

    private

    def before_compilation(source, destination, additional_files)
    end

    def after_compilation(source, destination, additional_files)
    end

    def create_command(source, destination, additional_files)
      "./#{destination}"
    end

    def prepare_compile_command(source, destination, additional_files)
      COMMAND_OPTIONS.map do |option|
        option.gsub /%SOURCE%|%DESTINATION%/,
          '%SOURCE%' => source, '%DESTINATION%' => destination
      end
    end
  end

  class Status
    attr_reader :output, :error, :success

    def initialize(output, error, status)
      @output, @error = output, error
      @success = status.success?
    end
  end
end
