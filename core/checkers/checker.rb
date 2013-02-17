require 'immutable_struct'

module Rucomasy
  module Checker
    Status = ImmutableStruct.new(:message, :points)
  end
end
