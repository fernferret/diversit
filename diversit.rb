require 'rubygems'
require 'sinatra'
require 'config/database'
require 'helpers/sinatra'

enable :sessions

# App modeled after:
# https://github.com/daddz/sinatra-dm-login/

## PATHS

get '/' do
  puts $auth
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
    @comment = Comment.create(:body=>params[:comment], :user=>User.get(2), :answer=>ans)
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
  Answer.create(:body=>params[:answer], :user=>User.get(2), :question=>@question)
  haml :question
end

get '/register' do
  haml :register
end

post '/register' do
  if params['email'] != '' and params['password'] != '' and params['password'] == params['pconfirm'] and params['bdate'] != '' and params['first'] != '' and params['last'] != ''
    User.create(:username => params['email'], :password => params['password'], :dob => params['bdate'], :firstname => params['first'], :lastname => params['last'])
    redirect '/'
  end
end

get '/user/login' do
  haml :login
end

post '/user/login' do
  if session[:user] = User.authenticate(params["login"], params["password"])
    flash("Login successful")
    redirect '/'
  else
    flash("Login failed - Try again")
    redirect '/user/login'
  end
end

get '/user/logout' do
  session[:user] = nil
  flash("Logout successful")
  redirect '/'
end
