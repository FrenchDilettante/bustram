require 'rails_helper'

describe V1::StopsApi do

  describe 'GET /api/v1/stops' do

    before(:each) do
      Stop.create name: 'Stop Test'
      Stop.create name: 'Another Stop'
    end

    it 'returns a list of stops' do
      get '/api/v1/stops'

      expect(response.status).to eq(200)
      parsed = JSON.parse(response.body)
      expect(parsed.length).to eq(2)
      expect(parsed[0].keys).to eq(['id', 'name'])
      expect(parsed[0]['id']).to eq('stop-test')
    end

    it 'filter stops by name' do
      get '/api/v1/stops?name=test'

      parsed = JSON.parse response.body
      expect(parsed.length).to be(1)
    end

  end

end