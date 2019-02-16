source 'http://rubygems.org'

ruby '2.5.3'

gem 'sinatra'
gem 'activerecord', '~> 4.2', '>= 4.2.6', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'bcrypt'
gem "tux"
gem 'sinatra-flash'
gem 'pg', '0.20'
gem 'dotenv'
gem 'rails_12factor' #errors from heroku logs

group :test, :development do
  #ruby '2.3.3'
  gem 'sqlite3', '~> 1.3.6'
  gem 'shotgun'
  gem 'pry'
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

