module Compiler
  def compile(source_file)
    destination, executable = prepare_executable

    before_compilation(source_file, destination)

    compile_command = prepare_compile_command(source_file, destination)
    status = Status.new(*Open3.capture3(*compile_command))

    after_compilation(source_file, destination)

    command = create_command(executable)
    return status, create_runnable(command, destination)
  end

  private

  def before_compilation(source_file, destination)
  end

  def after_compilation(source_file, destination)
  end
end
