require 'open3'

class Compiler
  attr_reader :stdout, :stderr, :status, :compiled_file

  class << self
    def compile(source, destination)
      compile_command = COMMAND_OPTIONS.map do |option|
        option.gsub /%SOURCE%|%DESTINATION%/,
          '%SOURCE%' => source, '%DESTINATION%' => destination
      end

      new *Open3.capture3(*compile_command), File.new(destination)
    end
  end

  private

  def initialize(stdout, stderr, status, compiled_file)
    @stdout, @stderr = stdout, stderr
    @status = status.success?
    @compiled_file = @status ? compiled_file : nil
  end
end