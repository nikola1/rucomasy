class Negation < Unary
  def evaluate(hash = {})
    -@operand.evaluate(hash)
  end
end
