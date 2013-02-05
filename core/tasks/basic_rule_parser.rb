require 'treetop'

grammer = File.join(File.dirname(__FILE__), 'grammer')
Treetop.load grammer

class BasicRuleParser < RuleParser
  def self.parse(rule)
    super(rule, ->(x){ ArithmeticParser.new.parse(x).to_sexp }, Expr)
  end

  private

  class ParsingError < Exception
  end
end
