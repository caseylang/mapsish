require 'spec_helper'
require 'pry'

# todo: move all this sample data
describe 'Location', :vcr => {cassette_name: 'Location/coordinates'} do

  describe '#create' do
    context 'with valid data' do
      subject(:location) { Location.create Locations.work}
      it 'creates a new record' do
        location
        expect(Location.count).to be > 0
      end

      describe 'responds to' do
        it('name') { location.name.should eq Locations.work[:name] }
        it('address') { location.address.should eq Locations.work[:address] }
        it('latitude') { location.latitude.should eq Locations.work_cordinates[:latitude] }
        it('longitude') { location.longitude.should eq Locations.work_cordinates[:longitude] }
      end
    end

    context 'with invalid data' do
      it { expect{ location = Location.create(Locations.empty) }.to raise_error DataMapper::SaveFailureError }
    end
  end
end