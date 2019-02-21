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
      erb :'/users/signup'
    end
  end

  get "/users/login" do
    erb :'/users/login'
  end

  post "/users/login" do
    #binding.pry
    user = User.find_by(username: params[:username].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      #binding.pry
      user.name == nil ? (erb :'/users/new') : (redirect to "/users/#{user.id}")
    else
      flash[:error] = ["Invalid Username or Password, please try again"]
      redirect to '/users/login'
    end
  end

  get '/users/:id' do
    #binding.pry
    if logged_in? && correct_id? && @user = current_user
      erb :'/users/show'
    else
      flash[:error] = ["Please log in to view your profile"]
      redirect to '/users/login'
    end
  end

  post '/users' do
    #binding.pry
    @user = current_user
    if @user.update(params[:user])
      redirect to "/users/#{@user.id}"
    else
      flash[:error] = @user.errors.full_messages
      erb :'/users/new'
    end

  end

  get '/users/:id/edit' do
    if logged_in? && correct_id? && @user = current_user
      erb :'/users/edit'
    else
      flash[:error] = ["Please log in to make changes"]
      redirect to '/users/login'
    end
  end


  patch '/users/:id' do
    #binding.pry
    user = current_user
    if user.update(params[:user])
      redirect "/users/#{user.id}"
    else
      #binding.pry
      flash[:error] = user.errors.full_messages
      redirect to "/users/#{user.id}/edit"
    end
  end

  get "/users/:id/logout" do
    session.clear
    redirect "/"
  end

  delete '/users/:id' do
    User.destroy(params[:id])
    redirect to '/'
  end

end