require 'immutable_struct'

module Checker
  Status = ImmutableStruct.new(:message, :points)
end
