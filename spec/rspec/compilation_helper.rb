require 'fileutils'

require_relative './source_examples'

module Rucomasy
  module CompilationHelper
    def successful?(status)
      status.success
    end

    def make_runner(runnable, options = {})
      Runner.new(runnable, options)
    end

    def run(runnable, options = {})
      make_runner(runnable, options).run
    end

    def create_tmp_dir
      @tmp_dir_location = File.join File.dirname(__FILE__), '../tmp'
      FileUtils.mkdir @tmp_dir_location unless File.exists? @tmp_dir_location
      @tmp_dir_location
    end

    def change_basic_native_compilers_tmp_dir(tmp_dir_location = @tmp_dir_location)
      BasicNativeCompiler.const_set :TMP_DIR_LOCATION, tmp_dir_location
    end

    def remove_tmp_dir
      FileUtils.rm_r @tmp_dir_location if File.exists? @tmp_dir_location
    end

    def random_dirname
      "#{Time.now.to_i}_#{Process.pid}_#{Random.rand(6661313)}"
    end

    def exists?(dirname)
      File.exists? dirname
    end

    def get_cpp_file_location(filename)
      SourceExamples.get_file_location filename, 'cpp'
    end

    def get_text_file_location(filename)
      SourceExamples.get_file_location filename, 'textfile'
    end
  end
end