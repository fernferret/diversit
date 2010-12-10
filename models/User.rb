require 'digest/sha1'
require 'dm-validations'

class User
  include DataMapper::Resource
  property :id,         Serial
  property :username,   String
  property :password,   String
  property :firstname,  String
  property :lastname,   String
  property :dob,        Date,   :default => DateTime.now
  
  has n, :answer
  has n, :comment
  
  ## Portions of this code from:
  ## https://github.com/daddz/sinatra-dm-login/
    
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass + salt)
  end
  
  def self.auth(login, pass)
    u = User.first(:login => login)
    return nil if u.nil?
    return u if User.encrypt(pass, u.salt) == u.password
    nil
  end
end