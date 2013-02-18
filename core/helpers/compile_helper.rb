module Rucomasy
  module CompileHelper
    COMPILERS = { cpp: CppCompiler }

    def self.compile(source, language)
      if COMPILERS.has_key? language.to_sym
        COMPILERS[language.to_sym].compile source
      else
        raise MissingCompilerError.new "There is no compiler for #{language}"
      end
    end

    class MissingCompilerError < Exception
    end
  end
end