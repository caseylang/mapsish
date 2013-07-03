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
  before do
    @locations = []
    @errors = []
  end

  get('/?') { redirect to '/api/locations'}

  get '/locations/?' do
    @locations = Location.all
    respond
  end

  put '/locations' do
    data = grab_data
    @locations << Location.create(name: data['name'], address: data['address'])
    respond
  end

  get '/locations/:id' do
    location = Location.get params[:id]
    @errors << RECORD_NOT_FOUND_MSG unless location
    @locations << location
    respond
  end

  post '/locations/:id' do
    data = grab_data
    location = Location.get params[:id]
    if location
      location.update(name: data['name'], address: data['address'])
      @locations << location
    else
      @errors << RECORD_NOT_FOUND_MSG
    end

    respond
  end

  delete '/locations/:id' do
    location = Location.get params[:id]
    if location
      location.destroy
    else
      @errors << RECORD_NOT_FOUND_MSG
    end
    respond
  end
end

RECORD_NOT_FOUND_MSG = 'Location record was not found.'

def grab_data
  request.body.rewind
  JSON.parse request.body.read
end

def respond
  json({locations: @locations, errors: @errors})
end