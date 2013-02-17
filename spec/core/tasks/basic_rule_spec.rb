require './core/rucomasy'

module Rucomasy
  describe BasicRule do
    def evaluate(rule, hash = {})
      BasicRule.new(rule).evaluate hash
    end

    it "evaluates variables" do
      evaluate('x', x: 13).should eq 13
      expect { evaluate('x') }.to raise_error(ArgumentError)
    end

    it "evaluates numbers" do
      evaluate('123').should eq 123
      evaluate('0.1').should eq 0.1
    end

    it "evaluates sine" do
      evaluate('(sin 0)').should eq 0.0
      evaluate('(sin 1)').should eq Math.sin(1)
    end

    it "evaluates cosine" do
      evaluate('(cos 0)').should eq 1.0
      evaluate('(cos 1)').should eq Math.cos(1)
    end

    it "evaluates negation" do
      evaluate('(- 3.0)').should eq -3.0
    end

    it "evaluates addition" do
      evaluate('(+ 1 2)').should eq 3
      evaluate('(+ x y)', x: 2, y:3).should eq 5
    end

    it "evaluates substraction" do
      evaluate('(- 1 2)').should eq -1
      evaluate('(- x y)', x: 3, y: 2).should eq 1
    end

    it "evaluates multiplication" do
      evaluate('(* 1 2)').should eq 2
      evaluate('(* 0.0 10.0)').should eq 0.0
    end

    it "evaluates division" do
      evaluate('(/ 1 2)').should eq 0
      evaluate('(/ 1.0 2.0)').should eq 0.5
    end

    it "evaluates maximum" do
      evaluate('(max 1 2)').should eq 2
      evaluate('(max 42.0 -42.0)').should eq 42.0
    end

    it "evaluates minimum" do
      evaluate('(min 1 2)').should eq 1
      evaluate('(min 42.0 -42.0)').should eq -42.0
    end

    it "evaluates nasted expressions" do
      evaluate('(abs (max (min (+ x y) 1) 2))', x: -1, y: 2).should eq 2
    end
  end
end