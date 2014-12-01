require 'rails_helper'

RSpec.describe Trip, :type => :model do
  correct_route = nil
  correct_timeframe = nil

  before(:each) do
    correct_route = Route.import '1d-131,1d,"DJF  Val de Maine > Eventard",,3,'
    correct_timeframe = Timeframe.import '2015H-DJF_01-Dimanche-71,0,0,0,0,0,0,1,20141109,20141207'
  end

  describe 'import' do

    it 'should parse a trip from the raw data' do
      trip = Trip.import '1d-131,2015H-DJF_01-Dimanche-71,2378970-2015H-DJF_01-Dimanche-71,"VAL de MAINE",1,606529,1d0045'

      expect(trip.route_id).to be(correct_route.id)
      expect(trip.timeframe_id).to be(correct_timeframe.id)
      expect(trip.code).to eq('2378970-2015H-DJF_01-Dimanche-71')
      expect(trip.headsign).to eq('VAL de MAINE')
      expect(trip.direction_id).to be(1)
      expect(Trip.all.count).to be(1)
    end

  end

end
