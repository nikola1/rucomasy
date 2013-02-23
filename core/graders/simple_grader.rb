module Rucomasy
  class SimpleGrader
    def initialize(result_handler)
      @result_handler = result_handler
    end

    def grade_all(for_grading)
      for_grading.each do |task, solutions|
        grade_task task, solutions
      end
    end

    def grade_task(task, solutions)
      solutions.each do |solution|
        @result_handler.handle task, solution, grade_solution(task, solution)
      end
    end

    private

    def grade_solution(task, solution)
      [].tap do |result|
        grade_testcases(task, solution) do |testcase, test_result|
          result << [testcase, test_result]
        end
      end
    end

    def grade_testcases(task, solution)
      compilation_status, runnable = CompileHelper.compile solution.source, solution.lang

      if compilation_status.success
        solution_runner = task.runner.new runnable, task.limits

        task.testcases.each do |testcase|
          result = grade_testcase testcase, solution_runner, task.checker, task.rule
          yield testcase, result
        end if task.testcases
      else
        task.testcases.each do |testcase|
          yield testcase, Result.new(:ce, compilation_status.error)
        end if task.testcases
      end
    end

    def grade_testcase(testcase, runner, checker, rule)
      run_status = runner.run stdin: testcase.input

      if run_status.exitcode == 0
        checker_status = checker.check run_status.output, testcase
        Result.new run_status.reason,
                   checker_status.message,
                   rule.evaluate(yours: checker_status.points),
                   run_status.time,
                   run_status.exitcode,
                   run_status.memory
      else
        Result.new run_status.reason,
                   run_status.error,
                   rule.evaluate(yours: 0.0),
                   run_status.time,
                   run_status.exitcode,
                   run_status.memory
      end
    end

    class Result
      attr_reader :status, :message, :runtime, :exitcode, :memory, :points

      def initialize(status, message = "", points = 0.0, runtime = -1, exitcode = 0, memory = -1)
        @status   = status
        @message  = message
        @runtime  = runtime
        @exitcode = exitcode
        @memory   = memory
        @points   = points
      end
    end
  end
end