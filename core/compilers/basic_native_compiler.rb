require 'open3'
require 'fileutils'

module Rucomasy
  module BasicNativeCompiler
    include Compiler

    private

    TMP_DIR_LOCATION = FileHelper::TMP_COMPILERS

    def prepare_compile_command(source_file, destination)
      @compiler_command_options.map do |option|
        option.gsub /%SOURCE%|%DESTINATION%/,
          '%SOURCE%' => source_file.path, '%DESTINATION%' => destination
      end
    end

    def create_command(executable)
      "./#{executable}"
    end

    def create_runnable(command, destination)
      Runnable.new command, File.dirname(destination)
    end

    def prepare_executable
      executable = FileHelper.random_filename
      return File.join(create_directory, executable), executable
    end

    def create_directory
      directory = File.join TMP_DIR, FileHelper.random_dirname
      if File.exists? directory
        raise CompilationError, "Destination directory already exists."
      else
        FileUtils.mkdir_p directory
      end
      File.absolute_path directory
    end
  end
end