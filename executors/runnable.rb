class Runnable
  attr_reader :command, :files, :parameters

  def initialize(command, files = [], parameters = [])
    @command, @files, @parameters = command, files, parameters
  end
end