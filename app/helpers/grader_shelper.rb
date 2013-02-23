module GraderSHelper
  def grade
    system 'touch grader/grade'
  end
end