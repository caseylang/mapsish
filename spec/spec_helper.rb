require 'rubygems'
require 'bundler'

Bundler.require
require_relative '../mapish_app'
require 'rspec'
require 'rack/test'
require 'json'

set :environment, :test

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{Dir.pwd}/spec/support/**/*.rb"].each {|f| require f}
require "#{Dir.pwd}/spec/fixtures/locations"

RSpec.configure do |config|
  config.include Rack::Test::Methods

  DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/test.sqlite3")
  DataMapper.finalize
  Location.auto_upgrade!
end

def app
  Sinatra::Application
end