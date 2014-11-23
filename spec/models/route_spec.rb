require 'rails_helper'

RSpec.describe Route, :type => :model do

  describe 'import' do

    it 'should parse a line from the raw data' do
      route = Route.import '3d-131,3d,"DJF Murs ERIGNE <> AquaVita <>   Monplaisir",,3,'

      expect(route.long_name).to eq('DJF Murs ERIGNE <> AquaVita <> Monplaisir')
      expect(route.code).to eq('3d-131')

      expect(Route.all.count).to be(1)
    end

  end

end
