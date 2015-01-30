require 'rails_helper'

RSpec.describe Route, :type => :model do

  describe 'import' do

    it 'should parse a line from the raw data' do
      route = Route.import '"3d-131,3d,""DJF Murs ERIGNE <> AquaVita <>   Monplaisir"",,3,"'

      expect(route.long_name).to eq('DJF Murs ERIGNE <> AquaVita <> Monplaisir')
      expect(route.code).to eq('3d-131')
      expect(route.transport_type).to eq('B')

      expect(Route.all.count).to be(1)
    end

    it 'should have bus and tram routes' do
      route = Route.import 'A-131,A,"ARDENNE - ROSERAIE",,0,'
      expect(route.transport_type).to eq('T')
    end

  end

end
