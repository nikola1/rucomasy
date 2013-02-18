module Rucomasy
  class Solution
    attr_reader :source, :lang

    def initialize(source, lang)
      @source, @lang = source, lang
    end
  end
end