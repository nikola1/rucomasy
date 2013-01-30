require 'fileutils'

class Runnable
  attr_reader :command, :path, :parameters

  def initialize(command, directory, parameters = [])
    @command, @parameters = command, parameters
    @path                 = File.absolute_path directory
    @dirname              = File.basename @path
  end

  # FIX: Linux only
  def timelimit(seconds)
    Runnable.new "timeout #{seconds} #{@command}", @directory, @parameters
  end

  # FIX: Not implemented
  def memorilimit(seconds)
    self
  end

  def move_to(directory)
    directory = File.absolute_path directory

    FileUtils.mkdir_p directory if not File.exists? directory
    FileUtils.mv @path, directory

    @path = File.join directory, @dirname
    self
  end

  def copy_to(directory)
    directory = File.absolute_path directory

    FileUtils.mkdir_p directory if not File.exists? directory
    FileUtils.cp_r @path, directory

    path = File.join directory, @dirname
    Runnable.new @command, path, @parameters
  end
end
