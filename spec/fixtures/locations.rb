module Locations
  extend self

  def home
    {name: 'Home', address: '800 W Campbell Rd, Richardson, TX'}
  end

  def work
    {name: 'Work', address: '800 Market St. San Francisco, CA 94102'}
  end

  def work_cordinates
    {latitude: 37.7854699, longitude: -122.406616}
  end

  def home_cordinates
    {latitude: 32.978299, longitude: -96.7515624}
  end

  def empty
    {name: '', address: ''}
  end
end