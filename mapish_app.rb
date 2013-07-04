require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'pry'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:///#{Dir.pwd}/development.sqlite3")
DataMapper::Model.raise_on_save_failure = true


class Location
  include DataMapper::Resource

  before :save, :geocode

  property :id, Serial
  property :name, String, required: true, messages: { presence: "Name is required" }
  property :address, String, required: true, messages: { presence: "Address is required" }
  property :latitude, Float, :writer => :private
  property :longitude, Float, :writer => :private

  def geocode
    self.latitude, self.longitude = Geocoder.coordinates @address
  end
end

DataMapper.finalize
Location.auto_upgrade!

class Mapish < Sinatra::Base
  register Sinatra::Namespace
  helpers Sinatra::JSON
  register Sinatra::JstPages

  configure do
    set :public_folder, File.dirname(__FILE__) + '/public'
    set :views, File.dirname(__FILE__) + '/public/templates'
  end

  serve_jst '/jst.js'

  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
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

    post '/locations' do
      data = grab_data
      location = Location.new(name: data['name'], address: data['address'])
      if location.valid?
        location.save
      else
        location.errors.map {|error| @errors << error }
      end
      @locations << location
      respond
    end

    get '/locations/:id' do
      location = Location.get params[:id]
      @errors << RECORD_NOT_FOUND_MSG unless location
      @locations << location
      respond
    end

    put '/locations/:id' do
      data = grab_data
      location = Location.get params[:id]
      if location
        location.attributes = { name: data['name'], address: data['address'] }
        if location.valid?
          location.save
        else
          location.errors.map {|error| @errors << error }
        end
      else
        @errors << RECORD_NOT_FOUND_MSG
      end
      @locations << location
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
end