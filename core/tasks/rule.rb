module Rucomasy
  class Rule
    def initialize(rule, rule_parser)
      @expr = rule_parser.parse rule
    end

    def evaluate(hash = {})
      @expr.evaluate hash
    end
  end
end