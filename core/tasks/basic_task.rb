require './task'

class BasicTask
  include Task

  attr_reader :statement, :type, :test_cases, :checker, :runner, :rule, :limits

  def initialize(description = {})
    @statement  = description.fetch :statement,  ""
    @type       = description.fetch :type,       Types::STANDART
    @test_cases = description.fetch :test_cases, []
    @checker    = description.fetch :checker,    Checker
    @runner     = description.fetch :runner,     Runner
    @rule       = description.fetch :rule,       Rules::DEFAULT
    @limits     = description.fetch :limits,     Limits::DEFAULT
  end
end
