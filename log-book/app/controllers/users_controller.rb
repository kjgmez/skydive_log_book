class UsersController < ApplicationController

  get '/user/signup' do
    erb :'/user/signup'
  end

  post '/user/signup' do
    #binding.pry
    if params[:username] == "" || params[:password] == ""
      flash[:error] = "Please complete all fields"
      redirect to '/user/signup'
    else
      if User.find_by(username: params[:username]) == nil
        User.create(username: params[:username], password: params[:password])
        redirect '/user/login'
      else
        flash[:error] = "That username is already in use"
        redirect to '/user/signup'
      end
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
      redirect to "/user/show"
    else
      flash[:error] = "Invalid Username or Password, please try again"
      redirect to '/user/login'
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
      flash[:error] = "Please log in to view your profile"
      redirect to '/user/login'
    end
  end

  get '/user/new' do
    erb :'/user/new'
  end

  post '/user/show' do
    @user = User.find(session[:user_id])
    binding.pry
    @user.update(params["user"])
    @user.save
    redirect '/user/show'
  end

  get '/user/edit' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'/user/edit'
    else
      flash[:error] = "Please log in to make changes"
      redirect to '/user/login'
    end
  end

  patch '/user/show' do
    user.find(session[:user_id])
    user.update(params[:user])
    redirect to '/user/show'
  end

  get "/user/logout" do
    session.clear
    redirect "/"
  end

end