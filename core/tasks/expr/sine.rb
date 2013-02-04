class Sine < Unary
  def evaluate(hash = {})
    Math.sin @operand.evaluate(hash)
  end
end
