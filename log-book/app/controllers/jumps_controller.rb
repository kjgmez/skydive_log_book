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
      @type = ["Belly","Free-fly","Angle","Wing-suit"]
      @user = User.find_by(session[:user_id])
      erb :'/jumps/new'
    else
      flash[:error] = "Please log in to create a jumps"
      redirect to '/users/login'
    end
  end

  post '/jumps' do
    binding.pry
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
    if logged_in? && jump_association
      @jump = Jump.find(params[:id])
        erb :'/jumps/show'
    else
      flash[:error] = "Incorrect user please log in again"
      redirect to '/users/logout'
    end
  end

  get '/jumps/:id/edit' do
    if logged_in? && jump_association
      @type = ["Belly","Free-fly","Angle","Wing-suit"]
      @jump = Jump.find(params[:id])
      @user = User.find_by(id: session[:user_id])
      erb :'/jumps/edit'
    else
      flash[:error] = "Incorrect user please log in again"
      redirect to '/users/logout'
    end
  end

  patch '/jumps/:id' do
    jump = Jump.find_by(id: params[:id])
    binding.pry
    if !jump.update(params[:jump])
      flash[:error] = jump.errors.full_messages
      redirect to "/jumps/#{jump.id}/edit"
    else
      redirect to "jumps/#{jump.id}"
    end
  end

  delete '/jumps/:id' do
    Jump.destroy(params[:id])
    redirect to "/jumps"
  end

end