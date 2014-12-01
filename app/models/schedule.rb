class Schedule < ActiveRecord::Base
  belongs_to :location
  belongs_to :stop
  belongs_to :trip

  def self.import line
    parts = line.split ','

    schedule = Schedule.new
    schedule.location = Location.find_by_code parts[3]
    schedule.stop = schedule.location.stop
    schedule.trip = Trip.find_by_code parts[0]
    schedule.departure_time = self.parse_time parts[2]
    schedule.stop_sequence = parts[4].to_i

    schedule.save!
    schedule
  end

  private

  def self.parse_time departure
    departure.split(':').join('').to_i
  end

end
