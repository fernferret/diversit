class Response
  include DataMapper::Resource
  property :id,         Serial
  property :parent_id,  Integer
  property :body,       Text, :length => 255
  property :choice,     Integer
  property :timestamp,  DateTime

  belongs_to :user
  belongs_to :question
  is :tree, :order => :timestamp

  def commentAgeRecursive
    countHash = Hash.new
    countHash['sum'] = self.user.age
    countHash['count'] = 1
    self.children.each do |response|
      result = response.commentAgeRecursive
      countHash['sum'] += result['sum']
      countHash['count'] += result['count']
    end
    return countHash
  end
end
