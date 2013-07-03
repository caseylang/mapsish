require 'spec_helper'

# todo: nuke both of these once things are really up and running
describe "Mapish" do
  describe "get /" do
    it "should display the index" do
      get "/"
      last_response.should be_ok
      last_response.body.should match 'howdy!'
    end
  end

  describe "get /json_test" do
    it "should return json" do
      get "/json_test"
      last_response.should be_ok
      last_response.content_type.should =~ /json/
      last_response.body.should match '{"testing":"Works!"}'
    end
  end
end