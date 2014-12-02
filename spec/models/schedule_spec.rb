require 'rails_helper'

RSpec.describe Schedule, :type => :model do
  correct_stop = nil
  correct_trip = nil

  before(:each) do
    correct_stop = Stop.import 'BARONNER,2861,"ST AUBIN LA SALLE",,2280507.0,386016.0,,,0,'
    correct_trip = Trip.import '1d-131,2015H-DJF_01-Dimanche-71,2378970-2015H-DJF_01-Dimanche-71,"VAL de MAINE",1,606529,1d0045'
  end

  describe 'import' do

    it 'should import a schedule from the raw data' do
      schedule = Schedule.import '2378970-2015H-DJF_01-Dimanche-71,13:50:00,13:50:00,BARONNER,1,0,0'

      expect(schedule.location.id).to be(correct_stop.locations.first.id)
      expect(schedule.stop.id).to be(correct_stop.id)
      expect(schedule.trip.id).to be(correct_trip.id)
      expect(schedule.departure_time).to be(135000)
      expect(schedule.stop_sequence).to be(1)
      expect(Schedule.all.count).to be(1)
    end

  end

  describe 'next' do

    it 'should provide the next schedules available' do
      # @TODO cannot be tested without complete data set
    end

  end

end
