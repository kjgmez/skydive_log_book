class UsersController < ApplicationController

  get '/user/signup' do
    erb :'/user/signup'
  end

  post '/user/signup' do
    binding.pry
    if params[:username] == "" || params[:password] == ""
      redirect '/users/failure'
    else
      User.create(name: params[:username], password: params[:password])
      redirect '/user/login'
    end
  end

  get "/user/login" do
    erb :'/user/login'
  end

  post "/user/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/user/account"
    else
      redirect to "/failure"
    end
  end

  get "/failure" do
    erb :'/user/failure'
  end

  get "/user/logout" do
    session.clear
    redirect "/"
  end

end