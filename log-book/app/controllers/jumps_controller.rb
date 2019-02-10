class JumpsController < ApplicationController

  get '/jump/new' do
    binding.pry
    @user = User.find_by(session[:user_id])
    erb :'/jump/new'
  end

  get '/jump/:id' do
    @jump = Jump.find(params[:id])
   erb :show
  end

end