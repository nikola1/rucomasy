module Compiler
  class SourceFile < File
    def initialize(filename)
      super File.absolute_path(filename)
    end
  end
end
