module Task
  module Types
    STANDART = :standart
  end

  class Rule
    def initialize(rule = "")
    end
  end

  module Rules
    DEFAULT = Rule.new
  end

  module Limits
    DEFAULT = {}
  end
end
