require 'fileutils'
require './core/rucomasy'
require './spec/rspec/compilation_helper'

module Rucomasy
  RSpec.configure do |c|
    c.include CompilationHelper
  end

  describe CompileHelper do
    before(:all) do
      create_tmp_dir
      change_basic_native_compilers_tmp_dir
    end

    after(:all) do
      remove_tmp_dir
    end

    def compile(filename, lang)
      file_location = get_cpp_file_location filename
      CompileHelper.compile Compiler::SourceFile.new(file_location), lang
    end

    it "compiles c++" do
      status, runnable = compile 'hello_world.cpp', :cpp
      successful?(status).should be true

      runnable.should_not be nil
      run(runnable).exitcode.should eq 0
      run(runnable).output.should eq "Hello, world!\n"
    end

    it "does not compile 'nikola'" do
      expect { compile('hello_world.cpp', 'nikola') }.to raise_error(CompileHelper::MissingCompilerError)
    end
  end
end