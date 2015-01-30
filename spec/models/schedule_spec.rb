#require 'rails_helper'

RSpec.describe Schedule, :type => :model do

  describe 'import' do

    it 'should import a schedule from the raw data' do
      trip_ids = {'2378970-2015H-DJF_01-Dimanche-71' => 111}
      stop_ids = {'BARONNER' => 222}
      location_ids = {'BARONNER' => 333}
      Schedule.import '2378970-2015H-DJF_01-Dimanche-71,13:50:00,13:50:00,BARONNER,1,0,0', location_ids, stop_ids, trip_ids

      schedule = Schedule.all.first
      expect(schedule.trip_id).to be(111)
      expect(schedule.stop_id).to be(222)
      expect(schedule.location_id).to be(333)
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

  describe 'parsed_departure_time' do

    it 'should convert the departure_time in a Time object' do
      schedule = Schedule.new departure_time: 123456
      expect(schedule.parsed_departure_time.strftime '%H:%M:%S').to eq('12:34:56')

      schedule = Schedule.new departure_time: 12345
      expect(schedule.parsed_departure_time.strftime '%H:%M:%S').to eq('01:23:45')

      schedule = Schedule.new departure_time: 241234
      parsed_departure_time = schedule.parsed_departure_time
      expect(parsed_departure_time.strftime '%H:%M:%S').to eq('00:12:34')
      expect(parsed_departure_time.day).to be(Time.now.day + 1)
    end

  end

end
