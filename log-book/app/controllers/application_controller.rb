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

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def jump_association
      jump = Jump.find(params[:id])
      jump.user_id == session[:user_id]
    end

    def correct_id?
      session[:user_id] == params[:id].to_i
    end
  end
end