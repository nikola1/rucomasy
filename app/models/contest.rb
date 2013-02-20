class Contest
  include DataMapper::Resource

  property :id,          Serial,   serial: true
  property :name,        String,   required: true
  property :description, Text,     allow_nil: true
  property :created_at,  DateTime, required: true
  property :created_at,  DateTime, required: true

  has n, :tasks
end