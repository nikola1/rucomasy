module Rucomasy
  class Cosine < Unary
    def evaluate(hash = {})
      Math.cos @operand.evaluate(hash)
    end
  end
end