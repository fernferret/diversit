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
end

class Question
  include DataMapper::Resource
  property :id,         Serial
  property :body,       Text
end

class Response
  include DataMapper::Resource
  property :id,         Serial
  property :body,       Text

## PATHS

get '/' do
  "Fish Dog"
end