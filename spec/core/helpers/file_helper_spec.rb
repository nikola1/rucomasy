require 'fileutils'
require './core/rucomasy'

module Rucomasy
  describe FileHelper do
    def exists?(filename)
      File.exists? filename
    end

    def remove_file(filename)
      FileUtils.rm filename
    end

    it "generate random dirname" do
      FileHelper::random_dirname.should_not eq FileHelper::random_dirname
    end

    it "generate random filename" do
      FileHelper::random_filename.should_not eq FileHelper::random_filename
    end

    it "generates random filename with the same extension as the provided one" do
      FileHelper::rand_file_with_ext("/test.ivan").should match /.*\.ivan\z/
    end

    it "creates random file" do
      first_random_file = FileHelper::create_random_file
      exists?(first_random_file).should be true

      second_random_file = FileHelper::create_random_file
      exists?(second_random_file).should be true

      first_random_file.should_not eq second_random_file

      remove_file first_random_file
      remove_file second_random_file

      exists?(first_random_file).should be false
      exists?(second_random_file).should be false
    end

    let(:current_dir) { File.absolute_path File.dirname(__FILE__) }

    it "creates random file in specific folder" do
      first_random_file = FileHelper::create_random_file current_dir
      exists?(first_random_file).should be true
      File.dirname(first_random_file).should eq current_dir

      second_random_file = FileHelper::create_random_file current_dir
      exists?(second_random_file).should be true
      File.dirname(second_random_file).should eq current_dir

      first_random_file.should_not eq second_random_file

      remove_file first_random_file
      remove_file second_random_file

      exists?(first_random_file).should be false
      exists?(second_random_file).should be false
    end
  end
end
