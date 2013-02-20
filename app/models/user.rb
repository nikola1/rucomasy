class User
  include DataMapper::Resource

  property :id,          Serial,     serial: true
  property :name,        String,     required: true
  property :email,       String,     required: true, format: :email_address, unique: true
  property :password,    BCryptHash, required: true
  property :created_at,  DateTime
end