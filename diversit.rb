require 'rubygems'
require 'sinatra'
require 'config/database'
require 'helpers/sinatra'
require 'haml'

enable :sessions

# App modeled after:
# https://github.com/daddz/sinatra-dm-login/

## PATHS

get '/' do
  @question = Question.first(:forday => Date.today)
  @u = session[:user]
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
  if logged_in?
    haml :comment_add
  else
    redirect '/register'
  end
end

post '/addcomment/:type/:id' do
  if logged_in?
    if params[:type] == 'answer'
      ans = Answer.get(params[:id])
      @comment = Comment.create(:body=>params[:comment], :user=>User.get(session[:user].id), :answer=>ans)
      redirect '/question/'+ans.question.id.to_s
    else
    
    end
  else
    redirect '/register'
  end
  haml :comment_add
end

get '/question/:id' do
  @question = Question.get(params[:id])
  haml :question
end

post '/question/:id' do
  if logged_in?
    @question = Question.get(params[:id])
    root = Response.create(:body=>params[:response], :user=>User.get(session[:user].id), :question=>@question)
    haml :question
  else
    redirect '/register'
  end
end

get '/register' do
  haml :register
end

post '/register' do
  if params['email'] != '' and params['password'] != '' and params['password'] == params['pconfirm'] and params['bdate'] != '' and params['first'] != '' and params['last'] != ''
    u = User.new
    u.username = params['email']
    u.password = params['password']
    u.dob = params['bdate']
    u.firstname = params['first']
    u.lastname = params['last']
    u.save
    redirect '/'
  end
end

get '/login' do
  haml :login
end

post '/login' do
  if session[:user] = User.auth(params["email"], params["password"])
    #flash("Login successful")
    redirect '/'
  end
end

get '/logout' do
  session[:user] = nil
  flash("Logout successful")
  redirect '/'
end

get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end
