module Rucomasy
  class Division < Binary
    def evaluate(hash = {})
      @left_operand.evaluate(hash) / @right_operand.evaluate(hash)
    end
  end
end