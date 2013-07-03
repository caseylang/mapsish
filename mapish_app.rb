require 'sinatra'
require 'sinatra/json'
require "sinatra/namespace"

configure do
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:///#{Dir.pwd}/development.sqlite3")
  DataMapper::Model.raise_on_save_failure = true
end

class Location
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :address, String
  # property :latitude, Float
  # property :longitude, Float
end

DataMapper.finalize
Location.auto_upgrade!

get '/' do
  'howdy!'
end

namespace '/api' do
  get('/?') { redirect to '/api/locations'}

  get '/locations/?' do
    locations = Location.all
    json({ locations: locations })
  end

  post '/locations' do
    request.body.rewind
    data = JSON.parse request.body.read
    location = Location.create(name: data['name'], address: data['address'])
    json({location: location})
  end
end

# get location/:id
# post location/
# put location/:id
# delete location/:id