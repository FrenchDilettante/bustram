require 'rails_helper'

describe V1::StopsApi do
  stop_test = nil

  before(:each) do
    stop_test = Stop.create name: 'Stop Test'
    Stop.create name: 'Another Stop'
  end

  describe 'GET /api/v1/stops' do

    it 'returns a list of stops' do
      get '/api/v1/stops'

      expect(response.status).to eq(200)
      parsed = JSON.parse(response.body)
      expect(parsed.length).to eq(2)
      expect(parsed[0].keys).to eq(['id', 'name', 'routes'])
      expect(parsed[0]['id']).to eq('stop-test')
    end

    it 'filter stops by name' do
      get '/api/v1/stops?q=test'

      parsed = JSON.parse response.body
      expect(parsed.length).to be(1)
    end

  end

  describe 'GET /api/v1/stops/:id' do

    it 'should get a stop by its id' do
      get '/api/v1/stops/stop-test'

      expect(response.status).to be(200)
      parsed = JSON.parse response.body
      expect(parsed['name']).to eq('Stop Test')
      expect(parsed.keys).to eq(['id', 'name', 'routes', 'locations'])
    end

    it 'should throw a 404 if not found' do
      get '/api/v1/stops/not-found'

      expect(response.status).to be(404)
    end

  end

  describe 'GET /api/v1/stops/:id/schedules' do

    before(:each) do
      timeframe = Timeframe.create start_date: Time.now - 1.days, end_date: Time.now + 1.days, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true
      route = Route.create short_name: 'T'
      trip = Trip.create timeframe: timeframe, route: route, headsign: 'headsign'
      next_time = (Time.now + 10.minutes).strftime('%H%M%S').to_i
      Schedule.create stop: stop_test, trip: trip, departure_time: next_time
    end

    it 'should get the next schedules' do
      get '/api/v1/stops/stop-test/schedules'

      expect(response.status).to be(200)
      parsed = JSON.parse response.body
      expect(parsed.length).to be(1)
      schedule = parsed[0]
      expect(schedule.keys).to eq(['departure_time', 'route_id', 'headsign'])
      expect(schedule['headsign']).to eq('headsign')
      expect(schedule['route_id']).to eq('T')
      expect(schedule['departure_time']).to_not be_nil
      expect { Time.parse schedule['departure_time'] }.not_to raise_error
      
    end

  end

end