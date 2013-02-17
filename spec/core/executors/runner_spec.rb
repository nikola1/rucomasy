require 'fileutils'
require './core/rucomasy'

require_relative '../source_examples'
module Rucomasy
  describe Runner do
    before(:all) do
      # Create new tmp directory for testing the compilation
      @tmp_dir_location = File.join File.dirname(__FILE__), 'tmp'
      FileUtils.mkdir @tmp_dir_location unless File.exists? @tmp_dir_location

      BasicNativeCompiler.const_set :TMP_DIR_LOCATION, @tmp_dir_location
    end

    after(:all) do
      FileUtils.rm_r @tmp_dir_location
    end

    def get_text_file_location(filename)
      SourceExamples.get_file_location filename, 'textfile'
    end

    def get_cpp_file_location(filename)
      SourceExamples.get_file_location filename, 'cpp'
    end

    def compile(filename)
      file_location = get_cpp_file_location filename
      CppCompiler.compile Compiler::SourceFile.new(file_location)
    end

    def successful?(status)
      status.success
    end

    def make_runner(runnable, options = {})
      Runner.new(runnable, options)
    end

    def run(runnable, options = {})
      make_runner(runnable, options).run
    end

    it "runs ok" do
      status, runnable = compile 'hello_world.cpp'
      successful?(status).should eq true
      runnable.should_not eq nil

      run_status = run runnable, memory: 64*1024*1024, time: 1
      run_status.exitcode.should eq 0
      run_status.reason.should eq :OK
      run(runnable).output.should eq "Hello, world!\n"
    end

    it "runs with non-zero return code" do
      status, runnable = compile 'nonzero_return_code.cpp'
      successful?(status).should eq true
      runnable.should_not eq nil

      run_status = run runnable, memory: 64*1024*1024, time: 1
      run_status.exitcode.should_not eq 0
      run_status.reason.should eq :NRC
    end

    it "runs with memory error" do
      status, runnable = compile 'memoryerror.cpp'
      successful?(status).should eq true
      runnable.should_not eq nil

      run_status = run runnable, memory: 64*1024*1024, time: 1
      run_status.exitcode.should_not eq 0
      run_status.reason.should eq :ME
    end

    it "runs with time limit" do
      status, runnable = compile 'timelimit.cpp'
      successful?(status).should eq true
      runnable.should_not eq nil

      run_status = run runnable, memory: 64*1024*1024, time: 1
      run_status.exitcode.should_not eq 0
      run_status.reason.should eq :TLE
    end

    it "add options and then runs" do
      status, runnable = compile 'timelimit.cpp'
      successful?(status).should eq true
      runnable.should_not eq nil

      runner = make_runner(runnable)
      runner.add_options(time: 1).run.reason.should eq :TLE

      runner = make_runner(runnable)
      runner.add_options time: 1
      runner.run.reason.should eq :TLE
    end

    it "remove options and then runs" do
      status, runnable = compile 'hello_world.cpp'

      run(runnable, memory: 1024).reason.should_not eq :OK

      runner = make_runner runnable, memory: 1024
      runner.remove_options([:memory]).run.reason.should eq :OK
    end

    it "runs with redirected stdin to file" do
      status, runnable = compile 'print_input.cpp'

      run(runnable, time: 1).output.should eq ""
      run(runnable, stdin: get_text_file_location('42')).output.should eq "42\n"
    end

    it "runs with redirected stdout to file" do
      status, runnable = compile 'hello_world.cpp'
      run(runnable).output.should eq "Hello, world!\n"

      test_output_file = File.join @tmp_dir_location, 'stdout_test'
      run runnable, stdout: test_output_file
      File.read(test_output_file).should eq "Hello, world!\n"
    end
  end
end