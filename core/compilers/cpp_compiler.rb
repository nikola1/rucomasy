module CppCompiler
  extend BasicNativeCompiler

  private

  @compiler_command_options = ["g++", "%SOURCE%", "-o", "%DESTINATION%",
                               "-O2" , "-s", "-static", "-lm", "-x", "c++"]
end
