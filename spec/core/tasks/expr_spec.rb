require './core/rucomasy'
require 'treetop'

Treetop.load './core/tasks/grammer'

module Rucomasy
  describe Expr do
    def parse(input)
      ArithmeticParser.new.parse(input).to_sexp
    end

    def evaluate(expression, hash = {})
      Expr.build(parse(expression)).evaluate(hash)
    end

    it "evaluates variables" do
      evaluate('x', x: 1).should eq 1
      evaluate('t', x: 1, t: 4).should eq 4
      expect { evaluate('t', x: 1) }.to raise_error(ArgumentError)
      expect { evaluate('t') }.to raise_error(ArgumentError)
    end

    it "evaluates numbers" do
      evaluate('1231').should eq 1231
      evaluate('0').should eq 0
      evaluate('-23.07').should eq -23.07
      evaluate('-0').should eq 0
    end

    it "evaluates sine" do
      evaluate('(sin 0)').should eq 0.0
      evaluate('(sin 123)').should eq Math.sin(123)
      evaluate("(sin #{Math.asin(0.3)})").should eq Math.sin(Math.asin(0.3))
    end

    it "evaluates cosine" do
      evaluate('(cos 0)').should eq 1.0
      evaluate('(cos 123)').should eq Math.cos(123)
      evaluate("(cos #{Math.acos(0.33)})").should eq Math.cos(Math.acos(0.33))
    end

    it "evaluates negation" do
      evaluate('(- 1231)').should eq -1231
      evaluate('(- x)', x: 3.0).should eq -3.0
    end

    it "evaluates addition" do
      evaluate('(+ 1 2)').should eq 3
      evaluate('(+ 13.0 2.0)').should eq 15.0
      evaluate('(+ x 2.0)', x: 7.0).should eq 9.0
    end

    it "evaluates substraction" do
      evaluate('(- 1 2)').should eq -1
      evaluate('(- 13.0 2.0)').should eq 11.0
      evaluate('(- x 2.0)', x: 7.0).should eq 5.0
    end

    it "evaluates multiplication" do
      evaluate('(* 1 2)').should eq 2
      evaluate('(* 8 2)').should eq 16
      evaluate('(* 13.0 2.0)').should eq 26.0
      evaluate('(* x 2.0)', x: 7.0).should eq 14.0
    end

    it "evaluates division" do
      evaluate('(/ 1 2)').should eq 0
      evaluate('(/ 8 2)').should eq 4
      evaluate('(/ 13.0 2.0)').should eq 6.5
      evaluate('(/ x 2.0)', x: 7.0).should eq 3.5
    end

    it "evaluates maximum" do
      evaluate('(max 74 9)').should eq 74
      evaluate('(max 9 74)').should eq 74
      evaluate('(max 9 -74)').should eq 9
      evaluate('(max -80 -74)').should eq -74
      evaluate('(max 8 8)').should eq 8
      evaluate('(max 1.5 2.0)').should eq 2.0
      evaluate('(max 1.5 -2.0)').should eq 1.5
      evaluate('(max x -21)', x: -10).should eq -10
      evaluate('(max x -21)', x: -22).should eq -21
    end

    it "evaluates minimum" do
      evaluate('(min 74 9)').should eq 9
      evaluate('(min 9 74)').should eq 9
      evaluate('(min 9 -74)').should eq -74
      evaluate('(min -80 -74)').should eq -80
      evaluate('(min 8 8)').should eq 8
      evaluate('(min 1.5 2.0)').should eq 1.5
      evaluate('(min 1.5 -2.0)').should eq -2.0
      evaluate('(min x -10)', x: -21).should eq -21
      evaluate('(min x -10)', x: -8).should eq -10
    end

    it "evaluates nasted expressions" do
      evaluate('(max (abs -123) (min x (- 13 1)))', x: 13).should eq 123
      evaluate('(/ (max x (* 12 15)) (abs -123))', x: -1213).should eq (12*15)/123
      evaluate('(max (- (abs -123)) (min 13 (- 13 1)))').should eq 12
      evaluate('(sin (abs (- x)))', x: 0.5).should eq Math.sin(0.5)
    end
  end
end