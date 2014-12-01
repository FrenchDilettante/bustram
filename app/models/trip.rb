class Trip < ActiveRecord::Base
  belongs_to :route
  belongs_to :timeframe

  def self.import line
    parts = line.split ','

    trip = Trip.new
    trip.route = Route.find_by_code parts[0]
    trip.timeframe = Timeframe.find_by_code parts[1]
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
