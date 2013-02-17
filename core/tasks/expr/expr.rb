module Rucomasy
  class Expr
    def self.build(tree)
      if tree.kind_of? Array
        case tree.first
          when :+        then Addition.new       Expr.build(tree[1]), Expr.build(tree[2])
          when :-        then Substraction.new   Expr.build(tree[1]), Expr.build(tree[2])
          when :*        then Multiplication.new Expr.build(tree[1]), Expr.build(tree[2])
          when :/        then Division.new       Expr.build(tree[1]), Expr.build(tree[2])
          when :max      then Maximum.new        Expr.build(tree[1]), Expr.build(tree[2])
          when :min      then Minimum.new        Expr.build(tree[1]), Expr.build(tree[2])
          when :negative then Negation.new       Expr.build(tree[1])
          when :sin      then Sine.new           Expr.build(tree[1])
          when :cos      then Cosine.new         Expr.build(tree[1])
          when :abs      then Absolute.new       Expr.build(tree[1])
          when :number   then Number.new         Expr.build(tree[1])
          when :variable then Variable.new       Expr.build(tree[1])
        end
      else
        tree
      end
    end
  end
end