require_relative './rule'
require_relative './basic_rule_parser'

class BasicRule < Rule
  def initialize(rule)
    super rule, BasicRuleParser
  end
end

puts BasicRule.new("(+ 1 2)").evaluate
