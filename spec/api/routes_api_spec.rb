require 'rails_helper'

describe V1::RoutesApi do

  before(:each) do
    Route.import '01-131,01,"BELLE BEILLE < > MONPLAISIR",,3,'
    Route.import 'A-131,A,"ARDENNE - ROSERAIE",,0,'
  end

  describe 'GET /api/v1/routes' do

    it 'returns a list of routes' do
      get '/api/v1/routes'

      expect(response.status).to eq(200)
      parsed = JSON.parse(response.body)
      expect(parsed.length).to eq(2)
      expect(parsed[0].keys).to eq(['id', 'name', 'type'])
      expect(parsed[0]['id']).to eq('01')
      expect(parsed[0]['type']).to eq('bus')
      expect(parsed[1]['type']).to eq('tramway')
    end

  end

end