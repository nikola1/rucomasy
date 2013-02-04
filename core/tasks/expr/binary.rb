class Binary < Expr
  def initialize(left_operand, right_operand)
    @left_operand, @right_operand = left_operand, right_operand
  end

  def ==(expr)
    self.class == expr.class and
      expr.left_operand? @left_operand and
      expr.right_operand? @right_operand
  end

  private

  def left_operand?(expr)
    @left_operand == expr
  end

  def right_operand?(expr)
    @right_operand == expr
  end
end

class Addition < Binary
  def evaluate(hash = {})
    @left_operand.evaluate(hash) + @right_operand.evaluate(hash)
  end
end

class Substraction < Binary
  def evaluate(hash = {})
    @left_operand.evaluate(hash) - @right_operand.evaluate(hash)
  end
end

class Multiplication < Binary
  def evaluate(hash = {})
    @left_operand.evaluate(hash) * @right_operand.evaluate(hash)
  end
end

class Division < Binary
  def evaluate(hash = {})
    @left_operand.evaluate(hash) / @right_operand.evaluate(hash)
  end
end

class Maximum < Binary
  def evaluate(hash = {})
    [@left_operand.evaluate(hash), @right_operand.evaluate(hash)].max
  end
end

class Minimum < Binary
  def evaluate(hash = {})
    [@left_operand.evaluate(hash), @right_operand.evaluate(hash)].min
  end
end
