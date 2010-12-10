require 'dm-validations'

class Question
  include DataMapper::Resource
  property :id,         Serial
  property :body,       String
  property :type,       String
  property :timestamp,  DateTime
  has n, :answer
end