module SimpleIOChecker
  include Checker

  def self.check(answer, testcase)
    if answer.chomp == File.read(testcase.output).chomp
      Status.new "OK", 1.0
    else
      Status.new "WA", 0.0
    end
  end

  def self.check_from_file(answer, testcase)
    if File.read(answer).chomp == File.read(testcase.output).chomp
      Status.new "OK", 1.0
    else
      Status.new "WA", 0.0
    end
  end
end