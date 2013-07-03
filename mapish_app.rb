require 'sinatra'
require 'sinatra/json'
require "sinatra/namespace"
require 'pry'

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
    data = grab_data
    location = Location.create(name: data['name'], address: data['address'])
    json({ location: location })
  end

  get '/locations/:id' do
    location = Location.get params[:id]
    json({ location: location })
  end

  post '/locations/:id' do
    data = grab_data
    location = Location.get params[:id]
    location.update(name: data['name'], address: data['address'])
    json({ location: location })
  end
end

def grab_data
  request.body.rewind
  JSON.parse request.body.read
end