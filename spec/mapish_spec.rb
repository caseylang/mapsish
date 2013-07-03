require 'spec_helper'

describe 'Mapish' do
  # todo: nuke this once things are really up and running
  describe 'get /' do
    it 'should display the index' do
      get '/'
      last_response.should be_ok
      last_response.body.should match 'howdy!'
    end
  end

  describe 'get /api/locations' do
    let(:response) do
      get '/api/locations'
      last_response
    end

    it 'returns json' do
      response.should be_ok
      response.content_type.should =~ /json/
    end

    it 'returns all locations' do
      Location.create(name: 'Work', address: '1234 1st St. Anywhere, State')
      body = JSON.parse(response.body)
      body.keys.should include 'locations'
      body['locations'].should be_a Array
      body['locations'].length.should == 1
    end
  end

  describe 'post /api/locations' do
    it 'creates a new location' do
      post '/api/locations', {name: 'Work', address: '1234 1st St. Anywhere, State'}.to_json, "CONTENT_TYPE" => "application/json"
      last_response.should be_ok
      Location.count.should > 0
    end
  end

  describe 'get /api/locations/:id' do
    let(:location) { Location.create(name: 'Work', address: '1234 1st St. Anywhere, State') }

    it 'returns the specified location' do
      get "/api/locations/#{location.id}"
      last_response.should be_ok
      body = JSON.parse(last_response.body)
      body['location']['name'].should match 'Work'
    end
  end

  describe 'put /api/locations/:id' do
    pending
  end

  describe 'delete /api/locations/:id' do
    pending
  end
end