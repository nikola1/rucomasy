class Contest
  include DataMapper::Resource

  property :id,          Serial,   serial: true
  property :name,        String,   required: true
  property :description, Text,     allow_nil: true
  property :start_date,  DateTime, required: true
  property :end_date,    DateTime, required: true

  has n, :tasks

  def has_started?
    DateTime.now >= start_date
  end

  def has_ended?
    DateTime.now >= start_date
  end

  def in_progress?
    has_started? && has_ended?
  end
end