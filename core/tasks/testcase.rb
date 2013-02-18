module Rucomasy
  class Testcase
    include Comparable

    attr_reader :number

    def initialize(number)
      @number = number
    end

    def <=>(testcase)
      number <=> testcase.number
    end
  end
end