class Choice
  include DataMapper::Resource
  property :id,         Serial
  property :body,       String

  belongs_to :question
end
