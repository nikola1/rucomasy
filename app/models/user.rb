require 'dm-is-authenticatable'

class User
  include DataMapper::Resource

  property :id,          Serial, serial: true
  property :username,    String, required: true, unique: true
  property :email,       String, format: :email_address
  property :created_at,  DateTime

  is :authenticatable

  has n, :submissions
end