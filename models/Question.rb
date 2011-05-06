class Question
  include DataMapper::Resource
  property :id,         Serial
  property :body,       String
  property :type,       String
  property :timestamp,  DateTime
  property :forday,     Date

  has n, :response

  def averageAge
    age = 0
    count = self.response.count
    if count == 0
      return "No Data Yet"
    end
    self.response.each do |resp|
      age += resp.user.age
    end
    return age / count
  end

  def commentAge
    age = 0
    count = 0
    counter = {}
    self.response.each do |resp|
      counter = resp.commentAgeRecursive
      age += counter['sum']
      count += counter['count']
    end

    if count > 0
      return age / count
    else
      return "No Data Yet"
    end
  end
end
