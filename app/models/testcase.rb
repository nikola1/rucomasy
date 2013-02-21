class Testcase < Rucomasy::SimpleIOTestcase
  include DataMapper::Resource

  property :id,     Serial,  serial: true
  property :number, Integer, required: true
  property :input,  FilePath
  property :output, FilePath

  belongs_to :task
end