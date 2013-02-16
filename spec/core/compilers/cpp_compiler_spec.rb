require 'fileutils'
require './core/rucomasy_core'

describe 'C++ Compiler' do
  before(:all) do
    # Create new tmp directory for testing the compilation
    @tmp_dir_location = File.join File.dirname(__FILE__), 'tmp'
    FileUtils.mkdir @tmp_dir_location unless File.exists? @tmp_dir_location

    BasicNativeCompiler.const_set :TMP_DIR_LOCATION, @tmp_dir_location
  end

  after(:all) do
    FileUtils.rm_r @tmp_dir_location
  end

  def compile(filename)
    file_location = get_cpp_file_location(filename)
    CppCompiler.compile(Compiler::SourceFile.new(file_location))
  end

  def get_cpp_file_location(filename)
    File.join File.dirname(__FILE__), '../source_examples/cpp', filename
  end

  def successful?(status)
    status.success
  end

  def run(runnable)
    Runner.new(runnable).run
  end

  it "compiles hello_world.cpp" do
    status, runnable = compile('hello_world.cpp')
    successful?(status).should eq true

    runnable.should_not eq nil
    run(runnable).exitcode.should eq 0
    run(runnable).output.should eq "Hello, world!\n"
  end

  it "doesn't compile broken.cpp" do
    status, runnable = compile('broken.cpp')
    successful?(status).should eq false
    runnable.should eq nil
  end
end