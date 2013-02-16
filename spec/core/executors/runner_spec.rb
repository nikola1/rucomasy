require 'fileutils'
require './core/rucomasy_core'

require_relative '../source_examples'

describe 'Runner' do
  before(:all) do
    # Create new tmp directory for testing the compilation
    @tmp_dir_location = File.join File.dirname(__FILE__), 'tmp'
    FileUtils.mkdir @tmp_dir_location unless File.exists? @tmp_dir_location

    BasicNativeCompiler.const_set :TMP_DIR_LOCATION, @tmp_dir_location
  end

  after(:all) do
    FileUtils.rm_r @tmp_dir_location
  end

  def get_cpp_file_location(filename)
    SourceExamples.get_file_location filename, 'cpp'
  end

  def compile(filename)
    file_location = get_cpp_file_location(filename)
    CppCompiler.compile(Compiler::SourceFile.new(file_location))
  end

  def successful?(status)
    status.success
  end

  def run(runnable, limits = {})
    Runner.new(runnable, limits).run
  end

  it "runs ok" do
    status, runnable = compile('hello_world.cpp')
    successful?(status).should eq true
    runnable.should_not eq nil

    run_status = run(runnable, memory: 64*1024*1024, time: 1)
    run_status.exitcode.should eq 0
    run_status.reason.should eq :OK
    run(runnable).output.should eq "Hello, world!\n"
  end

  it "runs with non-zero return code" do
    status, runnable = compile('nonzero_return_code.cpp')
    successful?(status).should eq true
    runnable.should_not eq nil

    run_status = run(runnable, memory: 64*1024*1024, time: 1)
    run_status.exitcode.should_not eq 0
    run_status.reason.should eq :NRC
  end

  it "runs with memory error" do
    status, runnable = compile('memoryerror.cpp')
    successful?(status).should eq true
    runnable.should_not eq nil

    run_status = run(runnable, memory: 64*1024*1024, time: 1)
    run_status.exitcode.should_not eq 0
    run_status.reason.should eq :ME
  end

  it "runs with time limit" do
    status, runnable = compile('timelimit.cpp')
    successful?(status).should eq true
    runnable.should_not eq nil

    run_status = run(runnable, memory: 64*1024*1024, time: 1)
    run_status.exitcode.should_not eq 0
    run_status.reason.should eq :TLE
  end
end
