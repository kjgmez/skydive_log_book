require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  register Sinatra::Flash
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :welcome
  end

  patch '/jump/:id' do
    jump = Jump.find_by(id: params[:id])
    binding.pry
    if params[:jump][:jump_number].empty? || params[:jump][:altitude].empty?
      flash[:error] = "Your entry mus have a Jump number and Altitude"
      redirect to "/jump/#{jump.id}/edit"
    else
      jump.update(params[:jump])
      redirect to "jump/#{jump.id}"
    end
  end

  delete '/jump/:id' do
    Jump.destroy(params[:id])
    redirect to "jump/index"
  end

  delete '/user/:id' do
    User.destroy(params[:id])
    redirect to '/'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end