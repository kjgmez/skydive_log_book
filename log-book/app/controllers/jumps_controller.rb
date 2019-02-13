class JumpsController < ApplicationController

  get '/jump/index' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'/jump/index'
    else
      flash[:error] = "Please log in to view you index"
      redirect to '/user/login'
    end
  end

  get '/jump/new' do
    if logged_in?
      #binding.pry
      @jumps = Jump.all
      @user = User.find_by(session[:user_id])
      erb :'/jump/new'
    else
      flash[:error] = "Please log in to create a jump"
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
        flash[:error] = "Incorrect User, you may only view your entries"
        redirect to '/jump/index'
      end
    else
      flash[:error] = "Please log in to make changes"
      redirect to '/user/login'
    end
  end

  get '/jump/:id/edit' do
    if logged_in?
      @jump = Jump.find(params[:id])
      @user = User.find_by(id: session[:user_id])
      if @jump.user_id == @user.id
        erb :'/jump/edit'
      else
        flash[:error] = "Incorrect User, you may only edit your entries"
        redirect to '/jump/index'
      end
    else
      flash[:error] = "Please log in to make changes"
      redirect to '/user/login'
    end
  end

  patch '/jump/:id' do
    jump = Jump.find_by(id: params[:id])
    jump.update(params[:jump])
    redirect to "jump/#{jump.id}"
  end

  get path '/jump/delete' do

    if logged_in?
      @jump = Jump.find(params[:id])
      @user = User.find_by(id: session[:user_id])
      if @jump.user_id == @user.id
        @jump.delete
        erb :'/jump/index'
      else
        flash[:error] = "Incorrect User, you may only delete your entries"
        redirect to '/jump/index'
      end
    else
      flash[:error] = "Please log in to make changes"
      redirect to '/user/login'
    end
  end

end