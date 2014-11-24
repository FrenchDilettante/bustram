require 'rails_helper'

RSpec.describe Stop, :type => :model do

  describe 'import' do

    it 'should parse a line from the raw data' do
      stop = Stop.import '1FMBL,11327,"FOCH MAISON BLEUE",,2278373.0,382488.0,,,0,place_CENTRE'

      expect(stop.name).to eq('Foch Maison Bleue')
      expect(stop.locations.length).to be(1)
      expect(stop.slug).to eq('foch-maison-bleue')
      
      location = stop.locations.first
      expect(location.code).to eq('1FMBL')
      expect(location.lat).to be(2278373)
      expect(location.lon).to be(382488)

      expect(Stop.all.count).to be(1)
      expect(Location.all.count).to be(1)
    end

    it 'should handle doubles' do
      Stop.import '1FMBL,11327,"FOCH MAISON BLEUE",,2278373.0,382488.0,,,0,place_CENTRE'
      stop = Stop.import '2FMBL,3788,"FOCH  MAISON BLEUE",,2278380.0,382482.0,,,0,place_CENTRE'

      expect(stop.locations.length).to be(2)

      location = stop.locations.last
      expect(location.code).to eq('2FMBL')

      expect(Stop.all.count).to be(1)
      expect(Location.all.count).to be(2)
    end

  end

end
