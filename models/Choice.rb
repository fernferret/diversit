class Choice
  include DataMapper::Resource
  property :id,         Serial
  property :body,       String, :length => 255

  belongs_to :question
end
