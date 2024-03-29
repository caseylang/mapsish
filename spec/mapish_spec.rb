require 'spec_helper'
require 'pry'

describe 'Mapish routes' do
  let(:location) { Location.create(Locations.work) }
  let(:response_body) { JSON.parse(last_response.body) }

  describe 'get /api/locations' do
    let(:response) do
      get '/api/locations'
      last_response
    end

    it 'returns json' do
      response.should be_ok
      response.content_type.should =~ /json/
    end

    it 'returns all locations', :vcr do
      location
      response.should be_ok
      response_body.should be_a Array
      response_body.length.should == 1
      response_body[0]['name'].should match Locations.work[:name]
    end
  end

  describe 'post /api/locations' do
    it 'creates a new location', :vcr do
      post '/api/locations', Locations.work.to_json, "CONTENT_TYPE" => "application/json"
      last_response.should be_ok
      Location.count.should > 0
      response_body['errors'].empty?.should be true

    end

    context 'with invalid data' do
      it 'returns errors' do
        post '/api/locations', Locations.empty.to_json, "CONTENT_TYPE" => "application/json"
        last_response.status.should eq 422
        response_body['errors'].empty?.should be false
      end
    end
  end

  describe 'get /api/locations/:id' do
    it 'returns the specified location', :vcr do
      get "/api/locations/#{location.id}"
      last_response.should be_ok
      response_body['name'].should match Locations.work[:name]
      response_body['longitude'].should eq Locations.work_coordinates[:longitude]
      response_body['errors'].empty?.should be true
    end

    context 'with an invalid id' do
      it 'returns an error' do
        get "/api/locations/999"
        last_response.status.should eq 404
        response_body['errors'].empty?.should be false
      end
    end
  end

  describe 'put /api/locations/:id' do
    it 'updates an existing location', :vcr do
      put "/api/locations/#{location.id}", Locations.home.to_json, "CONTENT_TYPE" => "application/json"
      last_response.should be_ok
      Location.count.should == 1
      response_body['name'].should match Locations.home[:name]
      response_body['errors'].empty?.should be true
    end

    context 'with an invalid id' do
      it 'returns an error' do
        put "/api/locations/999", Locations.home.to_json, "CONTENT_TYPE" => "application/json"
        last_response.status.should eq 404
        response_body['errors'].empty?.should be false
      end
    end

    context 'with invalid data' do
      it 'returns errors', :vcr do
        put "/api/locations/#{location.id}", Locations.empty.to_json, "CONTENT_TYPE" => "application/json"
        last_response.status.should eq 422
        response_body.empty?.should be false
      end
    end
  end

  describe 'delete /api/locations/:id' do
    it 'deletes an existing location', :vcr do
      delete "/api/locations/#{location.id}"
      last_response.should be_ok
      Location.count.should == 0
    end

    context 'with an invalid id' do
      it 'returns an error' do
        delete "/api/locations/999"
        last_response.status.should eq 404
        response_body.keys.should include 'errors'
        response_body['errors'].empty?.should be false
      end
    end
  end
end