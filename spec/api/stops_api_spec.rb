require 'rails_helper'

describe V1::StopsApi do

  before(:each) do
    Stop.create name: 'Stop Test'
    Stop.create name: 'Another Stop'
  end

  describe 'GET /api/v1/stops' do

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

  describe 'GET /api/v1/stops/:id' do

    it 'should get a stop by its id' do
      get '/api/v1/stops/stop-test'

      expect(response.status).to be(200)
      parsed = JSON.parse response.body
      expect(parsed['name']).to eq('Stop Test')
      expect(parsed.keys).to eq(['id', 'name', 'locations'])
    end

    it 'should throw a 404 if not found' do
      get '/api/v1/stops/not-found'

      expect(response.status).to be(404)
    end

  end

end