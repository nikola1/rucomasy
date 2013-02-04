class Variable < Unary
  def evaluate(hash = {})
    if hash.include? @operand
      hash[@operand]
    else
      raise ArgumentError, "Value for variable '#{@operand}' is missing."
    end
  end
end
