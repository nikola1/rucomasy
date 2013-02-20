class Submission
  include DataMapper::Resource

  property :id,         Serial,  serial: true
  property :tested,     Boolean, required: true, default: false
  property :status,     String,  required: true
  property :message,    String
  property :log,        Text
  property :result,     Float,   default: 0.0
  property :created_at, DateTime

  belongs_to :task, key: true
  belongs_to :user, key: true
end