class RuleParser
  def self.parse(rule, parse, expr)
    expr.build(parse.(rule))
  rescue
    raise ParsingError, "Wrong rule syntax."
  end

  private

  class ParsingError < Exception
  end
end
