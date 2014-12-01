require 'rails_helper'

RSpec.describe Timeframe, :type => :model do

  describe 'import' do

    it 'should parse a line from the raw data' do
      timeframe = Timeframe.import '2015H-LAVV06-Semaine-06,1,1,1,1,1,0,0,20141103,20141219'

      expect(timeframe.code).to eq('2015H-LAVV06-Semaine-06')
      
      expect(timeframe.monday).to be(true)
      expect(timeframe.tuesday).to be(true)
      expect(timeframe.wednesday).to be(true)
      expect(timeframe.thursday).to be(true)
      expect(timeframe.friday).to be(true)
      expect(timeframe.saturday).to be(false)
      expect(timeframe.sunday).to be(false)

      expect(timeframe.start_date.strftime '%Y-%m-%d').to eq('2014-11-03')
      expect(timeframe.end_date.strftime '%Y-%m-%d').to eq('2014-12-19')

      expect(Timeframe.all.count).to be(1)
    end

  end

  describe 'current_timeframes' do

    it 'should get the timeframe for the current date' do
      timeframeToday = Timeframe.create start_date: Date.yesterday, end_date: Date.tomorrow, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true
      timeframeFuture = Timeframe.create start_date: 2.days.from_now, end_date: 10.days.from_now, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true

      timeframes = Timeframe.current_timeframes
      expect(timeframes.count).to be(1)
      expect(timeframes.first.id).to be(timeframeToday.id)
    end

    it 'should get the timeframe for the current day of week' do
      incorrectTimeframe = Timeframe.create start_date: Date.yesterday, end_date: Date.tomorrow, monday: false, tuesday: false, wednesday: false, thursday: false, friday: false, saturday: false, sunday: false
      correctTimeframe = Timeframe.create start_date: Date.yesterday, end_date: Date.tomorrow, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true

      correctTimeframe[Timeframe.current_weekday.to_sym] = true

      timeframes = Timeframe.current_timeframes
      expect(timeframes.count).to eq(1)
      expect(timeframes.first.id).to be(correctTimeframe.id)
    end

  end

end
