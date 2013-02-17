module Rucomasy
  class Binary < Expr
    def initialize(left_operand, right_operand)
      @left_operand, @right_operand = left_operand, right_operand
    end

    def ==(expr)
      self.class == expr.class and
        expr.left_operand? @left_operand and
        expr.right_operand? @right_operand
    end

    protected

    def left_operand?(expr)
      @left_operand == expr
    end

    def right_operand?(expr)
      @right_operand == expr
    end
  end
end