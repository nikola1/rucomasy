require 'fileutils'
require 'fiber'

require './core/rucomasy'
require './spec/rspec/compilation_helper'

module Rucomasy
  RSpec.configure do |c|
    c.include CompilationHelper
  end

  describe SimpleGrader do
    before(:all) do
      create_tmp_dir
      change_basic_native_compilers_tmp_dir

      @test_set = (1..5).map do |x|
       SimpleIOTestcase.new(x, get_text_file_location("task.0#{x}.in"),
                               get_text_file_location("task.0#{x}.out"))
      end

      @task = BasicTask.new name: "Test task name", test_cases: @test_set

      solution_source = get_cpp_file_location('a_plus_b.cpp')
      @solution = Solution.new Compiler::SourceFile.new(solution_source), :cpp
    end

    after(:all) do
      remove_tmp_dir
    end

    it 'grades task' do
      fiber = Fiber.new do
        grader = SimpleGrader.new(Class.new do
          def self.handle(task, solution, results)
            Fiber.yield task, solution, results
          end
        end)
        grader.grade_task @task, [@solution]
        [nil, nil, nil]
      end

      while fiber.alive? do
        task, solution, results = fiber.resume
        unless task.nil?
          task.should eq @task
          solution.should eq @solution

          results.map do |t, r|
            (t.number != 5 && r.message == 'OK') ||
              (t.number == 5 && r.message == 'WA')
          end.inject(true, :&).should be true
        end
      end
    end
  end
end