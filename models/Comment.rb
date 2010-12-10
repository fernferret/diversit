require 'dm-validations'

class Comment
  include DataMapper::Resource
  property :id,         Serial
  property :body,       Text
  
  belongs_to :user
  belongs_to :answer
end