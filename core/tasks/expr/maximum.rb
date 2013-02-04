class Maximum < Binary
  def evaluate(hash = {})
    [@left_operand.evaluate(hash), @right_operand.evaluate(hash)].max
  end
end
