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

end
