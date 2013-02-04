class Unary < Expr
  def initialize(operand)
    @operand = operand
  end

  def ==(expr)
    self.class == expr.class and
      expr.operand? @operand
  end

  private

  def operand?(expr)
    @operand == expr
  end
end

class Number < Unary
  def evaluate(hash = {})
    @operand
  end
end

class Variable < Unary
  def evaluate(hash = {})
    if hash.include? @operand
      hash[@operand]
    else
      raise ArgumentError, "Value for variable '#{@operand}' is missing."
    end
  end
end

class Negation < Unary
  def evaluate(hash = {})
    -@operand.evaluate(hash)
  end
end

class Sine < Unary
  def evaluate(hash = {})
    Math.sin @operand.evaluate(hash)
  end
end

class Cosine < Unary
  def evaluate(hash = {})
    Math.cos @operand.evaluate(hash)
  end
end

class Absolute < Unary
  def evaluate(hash = {})
    @operand.evaluate(hash).abs
  end
end
