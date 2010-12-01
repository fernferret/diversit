require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'dm-core'
require 'dm-validations'
require 'dm-migrations'
require 'digest/md5'
require 'yaml'

## CONFIGURATION

config = YAML::load_file("config.yml")

DataMapper.setup(:default, config['db_location'])

## MODELS
class User
  include DataMapper::Resource
  property :id,         Serial
  property :username,   String
  property :password,   String
  property :firstname,  String
  property :lastname,   String
  property :dob,        Date
  
  has n, :response
end

class Question
  include DataMapper::Resource
  property :id,         Serial
  property :body,       Text
  property :type,       String
  
  has_n :response
end

# Our Sleep Deprived version of an interface
class Response
  include DataMapper::Resource
  property :id,         Serial
  property :body,       Text
  
  belongs_to :user
  
  has_n :comment
end

class Answer < Response
  belongs_to :question
end

class Comment < Response
  belongs_to :response
end
  
## PATHS

get '/' do
  "Fish Dog"
end