require 'fileutils'
require './core/rucomasy'
require './spec/rspec/compilation_helper'

module Rucomasy
  RSpec.configure do |c|
    c.include CompilationHelper
  end

  describe SimpleIOChecker do
    before(:all) do
      create_tmp_dir
    end

    after(:all) do
      remove_tmp_dir
    end

    let(:test_file) { File.join @tmp_dir_location, "testfile" }
    let(:answer_file) { File.join @tmp_dir_location, "answer" }

    it 'compares programs output with a file' do
      test_string = "asda 5\n12 \n. ,\n ! !\n "
      File.write test_file, test_string
      testcase = SimpleIOTestcase.new test_file, test_file

      checker_status = SimpleIOChecker.check test_string, testcase
      checker_status.message.should eq "OK"
      checker_status.points.should eq 1.0
    end

    it 'compares two files' do
      File.write test_file, "1\n"
      testcase = SimpleIOTestcase.new test_file, test_file

      File.write answer_file, "1"
      checker_status = SimpleIOChecker.check_from_file answer_file, testcase
      checker_status.message.should eq "OK"
      checker_status.points.should eq 1.0

      File.write answer_file, "2"
      checker_status = SimpleIOChecker.check_from_file answer_file, testcase
      checker_status.message.should eq "WA"
      checker_status.points.should eq 0.0
    end
  end
end