require 'treetop'

Treetop.load './core/tasks/grammer'

describe 'Parser' do
  def parse(input)
    ArithmeticParser.new.parse(input).to_sexp
  end

  it "parses numbers" do
    parse('0').should eq [:number, 0]
    parse('1').should eq [:number, 1]
    parse('1.01').should eq [:number, 1.01]
    parse('1231').should eq [:number, 1231]
    parse('-1').should eq [:number, -1]
    parse('-12.07').should eq [:number, -12.07]
  end

  it "parses binary procedures" do
    parse('(+ 1 2)').should eq [:+, [:number, 1], [:number, 2]]
    parse('(- 2 1)').should eq [:-, [:number, 2], [:number, 1]]
    parse('(* 11 22)').should eq [:*, [:number, 11], [:number, 22]]
    parse('(/ 91 2)').should eq [:/, [:number, 91], [:number, 2]]
    parse('(min -9 2)').should eq [:min, [:number, -9], [:number, 2]]
    parse('(max 7.0 -2)').should eq [:max, [:number, 7.0], [:number, -2]]
  end

  it "parses with random white spaces" do
    parse('(+    1  2)').should eq [:+, [:number, 1], [:number, 2]]
    parse('(- 2 1   )').should eq [:-, [:number, 2], [:number, 1]]
    parse('(* 11   22   )').should eq [:*, [:number, 11], [:number, 22]]
  end

  it "parses negation" do
    parse('(- ( - 3  1) )').should eq [:negative, [:-, [:number, 3],
                                                       [:number, 1]]]
    parse('(- x)').should eq [:negative, [:variable, :x]]
  end

  it "parses nested expressions" do
    parse('(+ 1 ( - 3  1) )').should eq [:+, [:number, 1],
                                             [:-, [:number, 3],
                                                  [:number, 1]]]

    parse('(min x (max 9 1))').should eq [:min, [:variable, :x],
                                                [:max, [:number, 9],
                                                       [:number, 1]]]

    parse('(abs (min x y))').should eq [:abs, [:min, [:variable, :x],
                                                     [:variable, :y]]]
  end
end