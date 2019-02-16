ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

env `set :database_file, "./database.yml`

require './app/controllers/application_controller'
require 'sinatra/base'
require 'sinatra/flash'
require_all 'app'