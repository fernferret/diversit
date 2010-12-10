require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'dm-core'
require 'dm-validations'
require 'dm-migrations'
require 'digest/md5'
require 'yaml'
require 'logger'

## CONFIGURATION

config = YAML::load_file("config.yml")
DataMapper::Logger.new($stdout, :debug)
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
  property :body,       String
  property :type,       String
  property :timestamp,  DateTime
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
  
  has n, :subcommentings, :child_key => [ :source_id ]
  has n, :subcomments, self, :through => :subcommentings, :via => :target
end

class Subcommenting
  include DataMapper::Resource
  property :source_id, Integer, :key => true, :min => 1
  property :target_id, Integer, :key => true, :min => 1
  
  belongs_to :source, 'Comment', :key => true
  belongs_to :target, 'Comment', :key => true
end

DataMapper.finalize
DataMapper.auto_upgrade!
## PATHS

get '/' do
  @users = User.all :order=>[:username]
  haml :index
end

get '/questions' do
  @questions = Question.all
  haml :question_archive
end

get '/addquestion' do
  haml :question_add
end

post '/addquestion' do
  @question = Question.create(:body=>params[:question], :type=>'free', :timestamp=>Time.now)
  haml :question_success
end

get '/addcomment/:type/:id' do
  haml :comment_add
end

post '/addcomment/:type/:id' do
  
  if params[:type] == 'answer'
    ans = Answer.get(params[:id])
    @comment = Comment.create(:body=>params[:comment], :user=>User.get(1), :answer=>ans)
    redirect '/question/'+ans.question.id.to_s
  else
    
  end
  haml :comment_add
end

get '/question/:id' do
  @question = Question.get(params[:id])
  haml :question
end

post '/question/:id' do
  @question = Question.get(params[:id])
  Answer.create(:body=>params[:answer], :user=>User.get(1), :question=>@question)
  haml :question
end

get '/register' do
  haml :register
end

post '/register' do
  if params['email'] != '' and params['password'] != '' and params['password'] == params['pconfirm'] and params['bdate'] != ''
    User.create(:username => params['email'], :password => params['password'], :dob => params['bdate'])
  end
end