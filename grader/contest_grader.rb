require_relative './result_handler'
require_relative '../db/data_mapper'

module ObjectMapper
  def self.export_task(task)
    Rucomasy::BasicTask.new name: task.name,
                       testcases: task.testcases,
                         checker: Rucomasy.const_get(task.checker),
                          runner: Rucomasy.const_get(task.runner),
                            rule: Rucomasy::BasicRule.new(task.rule)
  end
end

class ContestGrader < Rucomasy::SimpleGrader
  def initialize
    super(ResultHandler)
  end

  def grade_submission(submission)
    return if submission.status != 'not tested'

    submission.status = 'testing'
    submission.save

    grade_task ObjectMapper.export_task(submission.task), [submission.solution]
    submission.status = 'tested'
    submission.save

    puts submission.log
  end

  def grade_submissions(submissions)
    submissions.each do |submission|
      grade_submission submission
    end
  end

  def grade_not_tested
    grade_submissions ::Submission.all(status: 'not tested')
  end
end

# (cuteface)
class Pathname
  def path
    self
  end
end