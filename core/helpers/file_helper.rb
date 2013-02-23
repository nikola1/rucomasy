require 'fileutils'

module Rucomasy
  module FileHelper
    # Main directory
    PROJECT_DIR = File.absolute_path File.join(File.dirname(__FILE__), '..', '..')

    # Temporary folders
    TMP_DIR       = File.join PROJECT_DIR, 'tmp'
    TMP_COMPILERS = File.join TMP_DIR, 'compilers'
    TMP_RUNNERS   = File.join TMP_DIR, 'runners'

    # Folders
    MODELS      = File.join PROJECT_DIR, 'app/models'
    VIEWS       = File.join PROJECT_DIR, 'app/views'
    CONTROLLERS = File.join PROJECT_DIR, 'app/controllers'
    HELPERS     = File.join PROJECT_DIR, 'app/helpers'

    DB          = File.join PROJECT_DIR, 'db'
    FILES       = File.join PROJECT_DIR, 'files'
    PUBLIC      = File.join PROJECT_DIR, 'webroot'
    SUBMISSIONS = File.join PROJECT_DIR, 'files/submissions'
    TESTCASES   = File.join PROJECT_DIR, 'files/testcases'

    def self.create_random_file(dir = TMP_DIRECTORY)
      file_location = File.join dir, random_filename
      FileUtils.touch file_location
      File.absolute_path file_location
    end

    def self.random_dirname
      "#{Time.now.to_i}_#{Process.pid}_#{Random.rand(6661313)}"
    end

    def self.random_filename
      Random.new(Time.now.to_i*Random.rand(6661313)).rand.to_s
    end

    def self.create_runner_file
      create_random_file RUNNERS_DIRECTORY
    end

    def self.rand_file_with_ext(filename)
      "#{Time.now.to_i}#{Process.pid}#{File.extname(filename)}"
    end

    def self.require_files_from(dirname)
      Dir[File.join dirname, '*.rb'].each do |file|
        require "#{file}"
      end
    end
  end
end

