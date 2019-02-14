class JumpsController < ApplicationController

  get '/jumps' do
    #binding.pry
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'/jumps/index'
    else
      flash[:error] = "Please log in to view you index"
      redirect to '/users/login'
    end
  end

  get '/jumps/new' do
    if logged_in?
      #binding.pry
      @user = User.find_by(session[:user_id])
      erb :'/jumps/new'
    else
      flash[:error] = "Please log in to create a jumps"
      redirect to '/users/login'
    end
  end

  post '/jumps' do
    #binding.pry
    jump = Jump.new(params[:jump])
    if jump.save
      jump.user_id = session[:user_id]
      user = User.find_by(id: session[:user_id])
      user.jumps << jump
      redirect to "/jumps/#{jump.id}"
    else
      flash[:error] = jump.errors.full_messages
      redirect to '/jumps/new'
    end
  end

  get '/jumps/:id' do
    #binding.pry
    if logged_in? && proper_user
      @jump = Jump.find(params[:id])
        erb :'/jumps/show'
    else
      flash[:error] = "Please log in to make changes"
      redirect to '/users/login'
    end
  end

  get '/jumps/:id/edit' do
    if logged_in? && proper_user
      @jump = Jump.find(params[:id])
      @user = User.find_by(id: session[:user_id])
      erb :'/jumps/edit'
    else
      flash[:error] = "Incorrect user please log in again"
      redirect to '/users/logout'
    end
  end

end