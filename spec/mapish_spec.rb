require 'spec_helper'

describe "get /" do
  it "should display the index" do
    get "/"
    last_response.should be_ok
  end
end