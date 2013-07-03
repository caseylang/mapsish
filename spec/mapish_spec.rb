require 'spec_helper'
require 'pry'

# todo: move all this sample data
describe 'Mapish routes' do
  let(:location) { Location.create(name: 'Work', address: '1234 1st St. Anywhere, State') }
  let(:response_body) { JSON.parse(last_response.body) }

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
      response.should be_ok
      response_body.keys.should include 'locations'
      response_body['locations'].should be_a Array
      response_body['locations'].length.should == 1
    end
  end

  describe 'put /api/locations' do
    it 'creates a new location' do
      put '/api/locations', {name: 'Work', address: '1234 1st St. Anywhere, State'}.to_json, "CONTENT_TYPE" => "application/json"
      last_response.should be_ok
      Location.count.should > 0
      response_body['errors'].empty?.should be true
    end
    pending 'invalid data'
  end

  describe 'get /api/locations/:id' do
    it 'returns the specified location' do
      get "/api/locations/#{location.id}"
      last_response.should be_ok
      response_body['locations'][0]['name'].should match 'Work'
      response_body['errors'].empty?.should be true
    end

    context 'when given an invalid id' do
      it 'returns an error' do
        get "/api/locations/999"
        response_body['errors'].empty?.should be false
      end
    end
  end

  describe 'post /api/locations/:id' do
    it 'updates an existing location' do
      post "/api/locations/#{location.id}", {name: 'Home', address: '1234 Main Rd. Anywhere, State'}.to_json, "CONTENT_TYPE" => "application/json"
      last_response.should be_ok
      Location.count.should == 1
      response_body['locations'][0]['name'].should match 'Home'
      response_body['errors'].empty?.should be true
    end

    context 'when given an invalid id' do
      it 'returns an error' do
        post "/api/locations/999", {name: 'Home', address: '1234 Main Rd. Anywhere, State'}.to_json, "CONTENT_TYPE" => "application/json"
        response_body['errors'].empty?.should be false
      end
    end

    pending 'invalid data'
  end

  describe 'delete /api/locations/:id' do
    it 'deletes an existing location' do
      delete "/api/locations/#{location.id}"
      last_response.should be_ok
      Location.count.should == 0
    end

    context 'when given an invalid id' do
      it 'returns an error' do
        delete "/api/locations/999"
        response_body.keys.should include 'errors'
        response_body['errors'].empty?.should be false
      end
    end
  end
end