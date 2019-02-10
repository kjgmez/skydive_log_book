class JumpsController < ApplicationController

  get '/jump/new' do
    binding.pry
    @user = User.find_by(session[:user_id])
    erb :'/jump/new'
  end

  post '/jump/index' do
    @jump = Jump.create(params[:jump])
    @jump.user_id = session[:user_id]
    @jump.save
    redirect to "/jump/#{@jump.id}"
  end

  get '/jump/:id' do
    binding.pry
    @jump = Jump.find(params[:id])
    erb :'/jump/show'
  end

  get '/jump/:id/edit' do
    @jump = Jump.find(params[:id])
    @user = User.find_by(session[:user_id])
    erb :'/jump/edit'
  end
end