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
    #binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      #binding.pry
      redirect to "/user/profile"
    else
      redirect to "/user/failure"
    end
  end

  get '/user/profile' do
    binding.pry
    @user = User.find(session[:user_id])
    if !@user.name || !@user.license || !@user.canopy_size
      redirect '/user/details'
    else
      @jumps = Jump.all
      erb :'/user/profile'
    end
  end

  get '/user/details' do
    erb :'/user/details'
  end

  post '/user/profile' do
    @user = User.find(session[:user_id])
    binding.pry
    @user.update(params["user"])
    @user.save
    redirect '/user/profile'
  end

  get "/user/failure" do
    erb :'/user/failure'
  end

  get "/user/logout" do
    session.clear
    redirect "/welcome"
  end

end