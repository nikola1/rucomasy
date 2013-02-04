require 'treetop'
require_relative './rule_parser'
require_relative './expr'

Treetop.load 'grammer'

class BasicRuleParser < RuleParser
  def self.parse(rule)
    super(rule, ->(x){ ArithmeticParser.new.parse(x).to_sexp }, Expr)
  end

  private

  class ParsingError < Exception
  end
end
