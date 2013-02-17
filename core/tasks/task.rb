module Rucomasy
  module Task
    module Types
      STANDART = :standart
    end

    module Rules
      DEFAULT = BasicRule.new('yours')
    end

    module Limits
      LARGE = { memory: 128*1024*1024, time: 10.0 }
      DEFAULT = { memory: 64*1024*1024, time: 2.0 }
      STRICT = { memory: 16*1024*1024, time: 0.5 }
    end
  end
end