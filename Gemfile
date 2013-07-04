source 'https://rubygems.org'
ruby '1.9.3'

# Required by the app directly
gem 'sinatra', require: false
gem 'sinatra-contrib'

gem 'data_mapper'
gem 'dm-postgres-adapter', group: :production
gem 'geocoder'
gem 'sinatra-backbone', :require => 'sinatra/backbone'

group :development do
  gem 'dm-sqlite-adapter'
  gem 'compass'
  gem 'zurb-foundation'
end

group :development, :test do
  gem 'pry'
  gem 'rspec'
  gem 'rack-test'
end

group :test do
  gem 'vcr'
  gem 'database_cleaner'
  gem 'webmock'
end