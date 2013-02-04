require 'treetop'
require './core/tasks/basic_rule_parser' # FIXME: Should remove line 5 ("Treetop.load 'grammer'") in order to test.
require './core/tasks/expr'

Treetop.load './core/tasks/grammer'

describe 'Basic Rule Parser' do
  def parse(rule)
    BasicRuleParser.parse(rule)
  end

  # It is already tested so we can use it verify that everything parsed by
  # the BasicRuleParser is the same as what is expected to be parsed.
  def build(rule)
    Expr.build(ArithmeticParser.new.parse(rule).to_sexp)
  end

  it "parse simple structures" do
    parse('1').should eq build('1')
    parse('(+ 1 6)').should eq build('(+ 1 6)')
    parse('(* x 6)').should eq build('(* x 6)')
    parse('(/ x y)').should eq build('(/ x y)')
    parse('(max 65 8.0)').should eq build('(max 65 8.0)')
    parse('(max 65 8.0)').should_not eq build('(max 8.0 65)')
    parse('(min x 7)').should eq build('(min x 7)')
    parse('(abs -3)').should eq build('(abs -3)')
    parse('(- (- 1 2))').should eq build('(- (- 1 2))')
  end

  it "parse nested structures" do
    parse('(- (max 8 9))').should eq build('(- (max 8 9))')
    parse('(* (/ x (- 1 y)) (abs -8))').should eq build('(* (/ x (- 1 y)) (abs -8))')
  end
end