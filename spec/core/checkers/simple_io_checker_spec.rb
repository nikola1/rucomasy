require 'fileutils'
require './core/rucomasy_core'

describe 'Simple Input/Output Checker' do
  before(:all) do
    @tmp_dir_location = File.join File.dirname(__FILE__), 'tmp'
    FileUtils.mkdir @tmp_dir_location unless File.exists? @tmp_dir_location
  end

  after(:all) do
    FileUtils.rm_r @tmp_dir_location
  end

  def write_to_file(filename, content)
    file = File.new filename, 'w+'
    file.write content
    file.close
  end

  it 'compares programs output with a file' do
    test_string = "asda 5\n12 \n. ,\n ! !\n "
    test_file   = File.join @tmp_dir_location, "testfile"
    write_to_file test_file, test_string
    testcase = SimpleIOTestcase.new test_file, test_file

    checker_status = SimpleIOChecker.check test_string, testcase
    checker_status.message.should eq "OK"
    checker_status.points.should eq 1.0
  end

  it 'compares two files' do
    answer_file = File.join @tmp_dir_location, "answer"
    test_file   = File.join @tmp_dir_location, "testfile"

    write_to_file test_file, "1\n"
    testcase = SimpleIOTestcase.new test_file, test_file

    write_to_file answer_file, "1"
    checker_status = SimpleIOChecker.check_from_file File.new(answer_file), testcase
    checker_status.message.should eq "OK"
    checker_status.points.should eq 1.0

    write_to_file answer_file, "2"
    checker_status = SimpleIOChecker.check_from_file File.new(answer_file), testcase
    checker_status.message.should eq "WA"
    checker_status.points.should eq 0.0
  end
end
