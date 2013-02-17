module SimpleIOChecker
  include Checker

  def self.check(answer, testcase)
    if answer.chomp == testcase.output.readlines.join("").chomp
      Status.new "OK", 1.0
    else
      Status.new "WA", 0.0
    end
  end

  def self.check_from_file(answer, testcase)
    if answer.readlines.join("").chomp == testcase.output.readlines.join("").chomp
      Status.new "OK", 1.0
    else
      Status.new "WA", 0.0
    end
  end
end