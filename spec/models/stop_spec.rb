require 'rails_helper'

RSpec.describe Stop, :type => :model do

  describe 'import' do

    it 'should parse a line from the raw data' do
      stop = Stop.import '1FMBL,11327,"FOCH MAISON BLEUE",,2278373.0,382488.0,,,0,place_CENTRE'

      expect(stop.name).to eq('Foch Maison Bleue')
      expect(stop.code).to eq('1FMBL')
    end

  end

end
