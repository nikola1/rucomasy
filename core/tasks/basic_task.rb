module Rucomasy
  class BasicTask
    include Task

    attr_reader :name, :statement, :type, :test_cases, :checker, :runner,
      :rule, :limits

    def initialize(description = {})
      @name       = description.fetch :name,       ""
      @statement  = description.fetch :statement,  ""
      @type       = description.fetch :type,       Types::STANDART
      @test_cases = description.fetch :test_cases, []
      @checker    = description.fetch :checker,    SimpleIOChecker
      @runner     = description.fetch :runner,     Runner
      @rule       = description.fetch :rule,       Rules::DEFAULT
      @limits     = description.fetch :limits,     Limits::DEFAULT
    end
  end
end