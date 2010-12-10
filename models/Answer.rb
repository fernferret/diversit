require 'dm-validations'

class Answer
  include DataMapper::Resource
  property :id,         Serial
  property :body,       Text
  
  belongs_to :user
  belongs_to :question
  has n, :comment
end