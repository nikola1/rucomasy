module Rucomasy
  module SourceExamples
    def self.get_file_location(filename, type = nil)
      File.join File.dirname(__FILE__), 'source_examples', type, filename
    end
  end
end