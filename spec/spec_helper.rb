require 'rubygems'
require 'bundler'

Bundler.require
require_relative '../mapish_app'
require 'rspec'
require 'rack/test'
require 'json'

ENV['RACK_ENV'] = "test"

module RSpecMixin
  include Rack::Test::Methods
  def app() Mapish end
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{Dir.pwd}/spec/support/**/*.rb"].each {|f| require f}
require "#{Dir.pwd}/spec/fixtures/locations"

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RSpecMixin
  DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/test.sqlite3")
  DataMapper.finalize
  Location.auto_upgrade!
end