require 'rails_helper'

RSpec.describe Nook, type: :model do
  describe 'default attributes' do
    nook = Nook.new

    it 'has basic attributes' do
      expect(nook).to respond_to(
        :name, :description, :type, :place,
        :min_capacity, :max_capacity,
        :min_schedulable, :max_schedulable,
        :min_reservation_length, :max_reservation_length,
        :photos, :amenities, :use_policy,
        :bookable, :requires_approval, :repeatable
      )
    end

    it 'has ExtensibleAttributes' do
      expect(nook).to respond_to( :attrs, :hidden_attrs )
    end

    it 'has open_schedule' do
      expect(nook).to respond_to :open_schedule
    end

    it 'has a location' do
      expect(nook).to respond_to :location
    end

    it 'has a manager' do
      expect(nook).to respond_to :manager
    end

    it 'has reservations' do
      expect(nook).to respond_to :reservations
    end
  end

  describe '#set_defaults' do
    it 'sets ExtensibleAttributes defaults' do
      nook = Nook.new
      expect(nook.attrs).to eq( { } )
      expect(nook.hidden_attrs).to eq( { } )
    end

    it 'sets open_schedule after initialize' do
      location = FactoryGirl.create :location
      nook = Nook.new location: location
      expect(nook.open_schedule).to be_present
    end
  end

  describe '#amenities' do
    it 'can be an array' do
      nook = Nook.new amenities: [ 'projector', 'conference phone' ]
      expect( nook.amenities.count ).to eq( 2 )
    end

    it 'saves and refreshes as an array' do
      FactoryGirl.create :nook
      nook = Nook.last
      expect( nook.amenities.count ).to eq( FactoryGirl.attributes_for( :nook )[ :amenities ].count )
    end
  end

  describe '#location' do
    FactoryGirl.create :nook
    nook = Nook.last

    it 'has a location' do
      expect( nook.location ).to be_present
    end
  end

  describe '#manager' do
    FactoryGirl.create :nook
    nook = Nook.last

    it 'has a manager' do
      expect( nook.manager ).to be_present
    end
  end

  describe '#reservations' do
    FactoryGirl.create :reservation
    nook = Nook.last

    it 'has a reservation' do
      expect( nook.reservations.count ).to eq( 1 )
    end
  end
end