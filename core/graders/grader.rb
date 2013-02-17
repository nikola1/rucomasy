module Rucomasy
  module Grader
    class Result
      attr_reader :status, :message, :runtime, :exitcode, :memory, :points

      def initialize(status, message = "", runtime = -1, exitcode = 0, memory = -1, points = 0)
        @status   = status
        @message  = message
        @runtime  = runtime
        @exitcode = exitcode
        @memory   = memory
        @points   = points
      end

      module Status
        CE = :ce
        RE = :re
        OK = :ok
        TL = :tl
        ML = :ml
        UE = :ue
      end
    end
  end
end