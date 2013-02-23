class ResultHandler
  class << self
    def handle(task, solution, results)
      solution.submission.log = create_log task, solution, results
      solution.submission.result = sum_points results
    end

    def create_log(task, solution, results)
      log = "Task name: #{task.name}\n"
      log << "Solution id: #{solution.id}\n"
      log << "Test results:\n"

      results.each_with_object(log) do |(testcase, result), log|
        log << "##{testcase.number}: Status(#{result.status})"
        if result.message then log << ", Message(#{result.message})" end
        log << ", Exitcode(#{result.message})"
        log << ", Points(#{result.points})\n"
      end
    end

    def sum_points(results)
      results.inject(0.0) { |sum, (_, result)| sum + result.points }
    end
  end
end