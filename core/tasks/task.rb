class Task
  attr_reader :statement, :type, :test_cases, :checker, :runner

  def initialize(description = {})
    @statement  = description.fetch(:statement, "")
    @type       = description.fetch(:type, :standart)
    @test_cases = description.fetch(:test_cases, [])
    @checker    = description.fetch(:checker, Checker)
    @runner     = description.fetch(:runner, Runner)
  end
end

