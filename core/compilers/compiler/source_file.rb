module Compiler
  class SourceFile < File
    def initialize(filename, mode = "r", *opt)
      super File.absolute_path(filename), mode, *opt
    end
  end
end
