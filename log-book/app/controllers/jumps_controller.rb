class JumpsController < ApplicationController

  get '/jump/index' do
    binding.pry
    @jumps = Jump
    erb :'/jump/index'
  end
  get '/jump/new' do
    #binding.pry
    @jumps = Jump.all
    @user = User.find_by(session[:user_id])
    erb :'/jump/new'
  end

  post '/jump/index' do
    binding.pry
    @jump = Jump.create(params[:jump])
    @jump.user_id = session[:user_id]
    @jump.user = User.find_by(session[:user_id])
    @jump.save
    redirect to "/jump/#{@jump.id}"
  end

  get '/jump/:id' do
    #binding.pry
    @jump = Jump.find(params[:id])
    erb :'/jump/show'
  end

  get '/jump/:id/edit' do
    @jump = Jump.find(params[:id])
    @user = User.find_by(session[:user_id])
    erb :'/jump/edit'
  end

  patch '/jump/:id' do
    binding.pry
    jump = Jump.find_by(id: params[:id])
    jump.update(params[:jump])
    redirect to "jump/#{jump.id}"
  end
end