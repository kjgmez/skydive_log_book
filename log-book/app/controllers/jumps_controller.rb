class JumpsController < ApplicationController

  get '/jump/index' do
    @user = User.find_by(id: session[:user_id])
    erb :'/jump/index'
  end

  get '/jump/new' do
    if logged_in?
      #binding.pry
      @jumps = Jump.all
      @user = User.find_by(session[:user_id])
      erb :'/jump/new'
    else
      flash[:error] = "Please log in to make changes"
      redirect to '/user/login'
    end
  end

  post '/jump/index' do
    #binding.pry
    @jump = Jump.create(params[:jump])
    @jump.user_id = session[:user_id]
    @user = User.find_by(id: session[:user_id])
    @user.jumps << @jump
    @jump.save
    redirect to "/jump/#{@jump.id}"
  end

  get '/jump/:id' do
    if logged_in?
      binding.pry
      @jump = Jump.find(params[:id])
      @user = User.find_by(id: session[:user_id])
      if @jump.user_id == @user.id
        erb :'/jump/show'
      else
        erb :'/user/failure'
      end
    else
      erb :'/user/failure'
    end
  end

  get '/jump/:id/edit' do
    if logged_in?
      @jump = Jump.find(params[:id])
      @user = User.find_by(id: session[:user_id])
      if @jump.user_id == @user.id
        erb :'/jump/edit'
      else
        erb :'/user/failure'
      end
    else
      erb :'/user/failure'
    end
  end

  patch '/jump/:id' do
    jump = Jump.find_by(id: params[:id])
    jump.update(params[:jump])
    redirect to "jump/#{jump.id}"
  end

end