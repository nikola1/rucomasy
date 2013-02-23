module Rucomasy
  module Rat
    class ContestPersistanceManager < PersistanceManager
      def initialize
        @object_type = Contest

        @deleted     = "Contest was successfully deleted!"
        @not_deleted = "The contest was not deleted."
        @saved       = "Contest saved successfuly."
        @not_saved   = "Contest not saved."
        @not_exists  = "Such a contest doesn't exist."
      end

      def print(contest)
        puts "Name: #{contest.name}".ljust(40) + "Start date: #{contest.start_date}"
        puts "Contest id: #{contest.id}".ljust(40) + "End date:   #{contest.end_date}"
        unless contest.description.nil?
          puts "-" * CHARS_PER_LINE
          puts "Description:"
          puts contest.description.chars.each_slice(CHARS_PER_LINE).map { |x| x.join.lstrip }.join "\n"
        end
        puts "=" * CHARS_PER_LINE
      end
    end
  end
end