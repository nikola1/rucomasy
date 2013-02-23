module Rucomasy
  class BasicTask
    include Task

    attr_reader :name, :statement, :type, :testcases, :checker, :runner,
      :rule, :limits

    def initialize(description = {})
      @name       = description.fetch :name,       ""
      @statement  = description.fetch :statement,  ""
      @type       = description.fetch :type,       Types::STANDART
      @testcases  = description.fetch :testcases,  []
      @checker    = description.fetch :checker,    SimpleIOChecker
      @runner     = description.fetch :runner,     Runner
      @rule       = description.fetch :rule,       Rules::DEFAULT
      @limits     = description.fetch :limits,     Limits::DEFAULT
    end
  end
end