class UsersController < ApplicationController

  get '/users/signup' do
    erb :'/users/signup'
  end

  post '/users/signup' do
    #binding.pry
    @user = User.new(params)
    if @user.save
      redirect '/users/login'
    else
      flash[:error] = @user.errors.full_messages.uniq
      redirect to '/users/signup'
    end
  end

  get "/users/login" do
    erb :'/users/login'
  end

  post "/users/login" do
    #binding.pry
    @user = User.find_by(username: params[:username].downcase)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      #binding.pry
      redirect to "/users"
    else
      flash[:error] = "Invalid Username or Password, please try again"
      redirect to '/users/login'
    end
  end

  get '/users' do
    #binding.pry
    if logged_in?
      @user = User.find(session[:user_id])
      if !@user.name || !@user.license || !@user.canopy_size
        redirect '/users/new'
      else
        erb :'/users/show'
      end
    else
      flash[:error] = "Please log in to view your profile"
      redirect to '/users/login'
    end
  end

  get '/users/new' do
    erb :'/users/new'
  end

  post '/users' do
    if params[:user][:license].downcase.count("a-d") < 2
      user = User.find(session[:user_id])
      #binding.pry
      user.update!(params[:user])
      redirect '/users'
    else
      flash[:error] = "Please enter the letter of your license between A-D"
      redirect to '/users/new'
    end
  end

  get '/users/edit' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'/users/edit'
    else
      flash[:error] = "Please log in to make changes"
      redirect to '/users/login'
    end
  end

  get "/users/logout" do
    session.clear
    redirect "/"
  end

end