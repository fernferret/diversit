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
  
  has n, :response
end

# Our Sleep Deprived version of an interface
class Response
  include DataMapper::Resource
  property :id,         Serial
  property :body,       Text
  
  belongs_to :user
  
  has n, :comment
end

class Answer < Response
  belongs_to :question
end

class Comment < Response
  belongs_to :response
end

DataMapper.finalize
DataMapper.auto_upgrade!
## PATHS

get '/' do
  @users = User.all :order=>[:username]
  haml :index
end

get '/add/:user/:first/:last/:dob' do
  User.create(:username=>params[:user],:firstname=>params[:first],:lastname=>params[:last],:dob=>params[:dob])
  redirect '/'
end