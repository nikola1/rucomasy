require 'fileutils'
require './core/rucomasy'
require './spec/rspec/compilation_helper'

module Rucomasy
  RSpec.configure do |c|
    c.include CompilationHelper
  end

  describe CppCompiler do
    before(:all) do
      create_tmp_dir
      change_basic_native_compilers_tmp_dir
    end

    after(:all) do
      remove_tmp_dir
    end

    def compile(filename)
      file_location = get_cpp_file_location filename
      CppCompiler.compile Compiler::SourceFile.new(file_location)
    end

    it "compiles hello_world.cpp" do
      status, runnable = compile 'hello_world.cpp'
      successful?(status).should eq true

      runnable.should_not eq nil
      run(runnable).exitcode.should eq 0
      run(runnable).output.should eq "Hello, world!\n"
    end

    it "doesn't compile broken.cpp" do
      status, runnable = compile 'broken.cpp'
      successful?(status).should eq false
      runnable.should eq nil
    end
  end
end