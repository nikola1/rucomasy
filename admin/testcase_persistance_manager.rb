class TestcasePersistanceManager < PersistanceManager
  def initialize
    @object_type = Testcase

    @deleted     = "Testcases was successfully deleted!"
    @not_deleted = "The testcase was not deleted."
    @saved       = "Testcase saved successfuly."
    @not_saved   = "Testcase not saved."
    @not_exists  = "Such testcases doesn't exist."
  end

  def print(testcase)
    puts "Number: #{testcase.number}"
    puts "Task: #{testcase.task.name}"
    puts "Input: #{testcase.input}"
    puts "Output: #{testcase.output}"
    puts "=" * CHARS_PER_LINE
  end

  def add_from_folder(attributes)
    dirname = File.absolute_path attributes[:folder]
    files = Dir.entries(dirname)

    task = Task.get attributes[:task]
    puts task
    files.sort.each do |file|
      if file =~ /\A(\w*)\.(\d+)\.in\z/
        input = File.join(dirname, file)
        if files.member? "#{$1}.#{$2}.out"
          output = File.join(dirname, "#{$1}.#{$2}.out")

          add number: $2.to_i, input: input, output: output, task: task
        end
      end
    end
  end
end
