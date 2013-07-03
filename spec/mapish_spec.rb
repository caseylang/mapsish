require 'spec_helper'

# todo: nuke both of these once things are really up and running
describe 'Mapish' do
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
end