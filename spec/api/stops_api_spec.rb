require 'rails_helper'

describe V1::StopsApi do

  describe 'GET /api/v1/stops' do

    it 'returns a list of stops' do
      get '/api/v1/stops'

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq([])
    end

  end

end