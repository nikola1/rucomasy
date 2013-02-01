require './grader'

module SimpleGrader
  include Grader

  def grade_all(for_grading)
    for_grading.each do |task, solutions|
      grade_task task, solutions
    end
  end

  def grade_task(task, solutions)
    solutions.each do |solution|
      grade_solution task, solution
    end
  end

  def grade_solution(task, solution)
    compilation_status, runnable = Compiler.compile_solution solution
    if not status.success
      return [Result.new(Status.CE, compilation_status.error)]
    end
    solution_runner = task.runner.new runnable, task.limits

    task.test_cases.map do |test_case|
      run_status = solution_runner.run

      if run_status.exitcode == 0
        checker_message, checker_points = task.checker.check run_status.output, test_case
        Result.new(Status.OK, checker_message, -1,
          run_status.exitcode, -1, task.rule.evaluate(yours: checker_points))
      else
        Result.new(Status.RE, run_status.error)
      end
    end
  end
end
