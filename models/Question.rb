require 'dm-validations'

class Question
  include DataMapper::Resource
  property :id,         Serial
  property :body,       String
  property :type,       String
  property :timestamp,  DateTime
  property :forday,     Date
  
  has n, :answer
end