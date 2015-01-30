require 'rails_helper'

RSpec.describe Trip, :type => :model do

  describe 'import' do

    it 'should parse a trip from the raw data' do
      route_ids = {'1d-131' => 111}
      timeframe_ids = {'2015H-DJF_01-Dimanche-71' => 222}
      trip = Trip.import '1d-131,2015H-DJF_01-Dimanche-71,2378970-2015H-DJF_01-Dimanche-71,"VAL de MAINE",1,606529,1d0045', route_ids, timeframe_ids

      expect(trip.route_id).to be(111)
      expect(trip.timeframe_id).to be(222)
      expect(trip.code).to eq('2378970-2015H-DJF_01-Dimanche-71')
      expect(trip.headsign).to eq('VAL de MAINE')
      expect(trip.direction_id).to be(1)
      expect(Trip.all.count).to be(1)
    end

  end

end
