module Locations
  extend self

  def home
    {name: 'Home', address: '1234 Main Rd. Anywhere, State'}
  end

  def work
    {name: 'Work', address: '1234 1st St. Anywhere, State'}
  end

  def empty
    {name: '', address: ''}
  end
end