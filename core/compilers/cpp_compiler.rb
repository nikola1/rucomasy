require_relative './compiler.rb'

class CppCompiler < Compiler
  class << Compiler
    COMMAND_OPTIONS = ["g++", "%SOURCE%","-o", "%DESTINATION%" ,"-O2" ,"-s", "-static", "-lm", "-x" ,"c++"]
  end
end
