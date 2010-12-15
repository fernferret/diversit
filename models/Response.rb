require 'dm-validations'

class Response
  include DataMapper::Resource
  property :id,         Serial
  property :parent_id,  Integer
  property :body,       Text
  property :timestamp,  DateTime
  
  belongs_to :user
  belongs_to :question
  is :tree, :order => :timestamp
end
