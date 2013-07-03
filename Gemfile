source 'https://rubygems.org'

# Required by the app directly
gem 'sinatra', require: false
gem 'data_mapper'
gem 'dm-postgres-adapter', group: :production

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
  gem 'webmock'
end