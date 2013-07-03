require 'sinatra'

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

get '/location' do
  @locations = Location.all
  index = "<p><%= Location.all.count %></p>
          <% @locations.each do |location| %>
            <p><%= location.id %>:<%= location.name %> - <%= location.address %></p>
          <% end %>"
  erb index
end