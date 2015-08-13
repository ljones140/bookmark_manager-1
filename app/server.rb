require 'sinatra/base'
require 'sinatra/flash'
require './data_mapper_setup'
require_relative './helpers/apphelpers.rb'

class Bookmark_Manager < Sinatra::Base

  use Rack::MethodOverride

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  set :views, proc { File.join(root,'..','views') }
  set :public_folder, proc { File.join(root, '..' 'public') }

  get '/' do
    erb :index
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    tags = params[:tag].split(/\s/).map { | tag | Tag.first_or_create(name: tag) }
    Link.create(url: params[:url], title: params[:title], tags: tags)
    redirect to('/links')
  end

  get '/links/new' do
    erb :'links/new'
  end

  get '/tags/:name' do
    tag = (Tag.first(name: params[:name]))
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/links')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The emails or password is incorrect']
    end
  end

  delete '/sessions' do
    session.clear
    flash.now[:notice] = ['goodbye!']
  end

  helpers do
     include AppHelpers
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
