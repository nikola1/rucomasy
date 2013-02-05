class BasicRule < Rule
  def initialize(rule)
    super rule, BasicRuleParser
  end
end
