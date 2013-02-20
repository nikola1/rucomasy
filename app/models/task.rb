class Task
  include DataMapper::Resource

  property :id,        Serial, serial: true
  property :name,      String, required: true
  property :statement, Text,   allow_nil: true
  property :checker,   String, required: true, default: 'SimpleIOChecker'
  property :runner,    String, required: true, default: 'Runner'
  property :rule,      String, required: true, default: 'yours'
  property :limits,    String

  has n, :testcases

  belongs_to :contest, key: true
end