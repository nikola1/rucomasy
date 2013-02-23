class Solution
  include DataMapper::Resource

  property :id,         Serial,   serial: true
  property :source,     FilePath, required: true
  property :lang,       String,   required: true
  property :created_at, DateTime

  belongs_to :submission
end