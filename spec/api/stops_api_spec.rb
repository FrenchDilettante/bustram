require 'rails_helper'

describe V1::StopsApi do

  describe 'GET /api/v1/stops' do

    before(:each) do
      Stop.create name: 'Stop Test'
      Stop.create name: 'Another Stop'
    end

    it 'returns a list of stops' do
      get '/api/v1/stops?q=stop'

      expect(response.status).to eq(200)
      parsed = JSON.parse(response.body)
      expect(parsed.length).to eq(2)
      expect(parsed[0].keys).to eq(['id', 'name', 'locations'])
      expect(parsed[0]['id']).to eq('stop-test')
    end

    it 'filter stops by name' do
      get '/api/v1/stops?q=test'

      parsed = JSON.parse response.body
      expect(parsed.length).to be(1)
    end

    it 'should require name to be a valid search term' do
      get '/api/v1/stops'
      expect(response.status).to be(400)

      get '/api/v1/stops?q=yo'
      expect(response.status).to be(400)
    end

  end

end