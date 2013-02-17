module Rucomasy
  class Minimum < Binary
    def evaluate(hash = {})
      [@left_operand.evaluate(hash), @right_operand.evaluate(hash)].min
    end
  end
end