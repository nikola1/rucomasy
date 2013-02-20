class Solution
  include DataMapper::Resource

  property :id,          Serial,   serial: true
  property :source_file, FilePath, required: true
  property :language,    String,   required: true
  property :created_at,  DateTime

  belongs_to :submission, key: true
end