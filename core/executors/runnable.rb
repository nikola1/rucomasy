require 'fileutils'

module Rucomasy
  class Runnable
    attr_reader :command, :parameters

    def initialize(command, directory, parameters = [])
      @command, @parameters = command, parameters
      full_dir_path         = File.absolute_path directory
      @path                 = File.dirname full_dir_path
      @dirname              = File.basename full_dir_path
    end

    def fullpath
      File.join @path, @dirname
    end

    def move_to(directory)
      directory = File.absolute_path directory

      FileUtils.mkdir_p directory if not File.exists? directory
      FileUtils.mv fullpath, directory

      @path = directory
      self
    end

    def copy_to(directory)
      directory = File.absolute_path directory

      FileUtils.mkdir_p directory if not File.exists? directory
      FileUtils.cp_r fullpath, directory

      Runnable.new @command, File.join(directory, @dirname), @parameters
    end
  end
end