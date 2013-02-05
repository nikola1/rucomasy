require 'open3'

class Compiler
  def compile(source, executable, additional_files = [])
    destination = File.join(create_directory, executable)

    before_compilation(source, destination, additional_files)

    compile_command = prepare_compile_command(source, destination, additional_files)
    status = Status.new *Open3.capture3(*compile_command)

    after_compilation(source, destination, additional_files)

    command = create_command(executable, additional_files)
    return status, create_runnable(command, destination, additional_files)
  end

  class Status
    attr_reader :output, :error, :success

    def initialize(output, error, status)
      @output, @error = output, error
      @success = status.success?
    end
  end

  private

  def before_compilation(source, destination, additional_files)
  end

  def prepare_compile_command(source, destination, additional_files)
    COMMAND_OPTIONS.map do |option|
      option.gsub /%SOURCE%|%DESTINATION%/,
        '%SOURCE%' => source, '%DESTINATION%' => destination
    end
  end

  def after_compilation(source, destination, additional_files)
  end

  def create_command(executable, additional_files)
    "./#{executable}"
  end

  def create_runnable(command, destination, additional_files)
    Runnable.new(command, File.dirname(destination))
  end

  def create_directory
    directory_name = "../tmp/#{Time.now.to_i}_#{Process.pid}"
    FileUtils.mkdir_p directory_name if not File.exists? directory_name
    directory_name
  end
end
