class Absolute < Unary
  def evaluate(hash = {})
    @operand.evaluate(hash).abs
  end
end
