require 'open3'

require_relative './runnable.rb'
require_relative '../compilers/cpp_compiler.rb'

class Runner
  def initialize(runnable, limits = {})
    @runnable, @limits = runnable, limits
    @limits['timelimit'] = @limits['timelimit'] || 1.0
  end

  def run(limits = {})
    limits = @limits.merge limits

    out, err, status = Open3.capture3 @runnable.command

    Runnable::Status.new out, err, status
  end
end