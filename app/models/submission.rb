class Submission
  include DataMapper::Resource

  property :id,         Serial, serial: true
  property :status,     String, required: true, default: 'not tested'
  property :message,    String
  property :log,        Text
  property :result,     Float,  default: 0.0
  property :created_at, DateTime

  belongs_to :task
  belongs_to :user

  has 1, :solution
end