class Unary < Expr
  def initialize(operand)
    @operand = operand
  end

  def ==(expr)
    self.class == expr.class and
      expr.operand? @operand
  end

  protected

  def operand?(expr)
    @operand == expr
  end
end
