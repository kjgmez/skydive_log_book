class UsersController < ApplicationController

  get '/user/signup' do
    erb :'/user/signup'
  end

  post '/user/signup' do
    #binding.pry
    if params[:username] == "" || params[:password] == "" #|| User.find_by(username: params[:username]).name.empty? == false
      redirect '/user/failure'
    else
      User.create(username: params[:username], password: params[:password])
      redirect '/user/login'
    end
  end

  get "/user/login" do
    erb :'/user/login'
  end

  post "/user/login" do
    binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      #binding.pry
      redirect to "/user/show"
    else
      redirect to "/user/failure"
    end
  end

  get '/user/show' do
    #binding.pry
    if logged_in?
      @user = User.find(session[:user_id])
      if !@user.name || !@user.license || !@user.canopy_size
        redirect '/user/new'
      else
        erb :'/user/show'
      end
    else
      redirect '/user/failure'
    end
  end

  get '/user/new' do
    erb :'/user/new'
  end

  post '/user/show' do
    @user = User.find(session[:user_id])
    #binding.pry
    @user.update(params["user"])
    @user.save
    redirect '/user/show'
  end

  get '/user/edit' do
    @user = User.find(session[:user_id])
    erb :'/user/edit'
  end

  patch '/user/show' do
    user.find(session[:user_id])
    user.update(params[:user])
    redirect to '/user/show'
  end

  get "/user/failure" do
    erb :'/user/failure'
  end

  get "/user/logout" do
    session.clear
    redirect "/user/login"
  end

end