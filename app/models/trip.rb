class Trip < ActiveRecord::Base
  belongs_to :route
  belongs_to :timeframe

  def self.import line, route_ids, timeframe_ids
    parts = line.split ','

    trip = Trip.new
    trip.route_id = route_ids[parts[0]]
    trip.timeframe_id = timeframe_ids[parts[1]]
    trip.code = parts[2]
    trip.headsign = self.parse_headsign parts[3]
    trip.direction_id = parts[4].to_i

    trip.save!
    trip
  end

  private

  def self.parse_headsign headsign
    headsign[1,headsign.length-2]
  end

end
