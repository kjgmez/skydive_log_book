require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure do
    enable :sessions
    set :session_secret, "l0gg_y0ur_jump"
    set :views, Proc.new{File.join(root, "../views.")}
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