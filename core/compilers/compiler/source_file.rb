module Rucomasy
  module Compiler
    class SourceFile
      attr_reader :path

      def initialize(filename)
        @path = File.absolute_path(filename)
      end
    end
  end
end
