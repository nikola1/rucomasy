module Rucomasy
  module Rat
    class TaskPersistanceManager < PersistanceManager
      def initialize
        @object_type = Task

        @deleted     = "Task was successfully deleted!"
        @not_deleted = "The task was not deleted."
        @saved       = "Task saved successfuly."
        @not_saved   = "Task not saved."
        @not_exists  = "Such a task doesn't exist."
      end

      def print(task)
        puts "Name: #{task.name}".ljust(40) + "Runner:  #{task.runner}"
        puts "Task id: #{task.id}#{', Task: ' + task.contest.name if task.contest}".ljust(40) + "Checker: #{task.checker}"
        unless task.statement.nil?
          puts "-" * CHARS_PER_LINE
          puts "Statement:"
          puts task.statement.chars.each_slice(CHARS_PER_LINE).map { |x| x.join.lstrip }.join "\n"
        end
        puts "=" * CHARS_PER_LINE
      end
    end
  end
end