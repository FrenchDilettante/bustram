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

  def self.next stop
    current_timeframes = Timeframe.current_timeframes.map {|tf| tf.id}
    self.
      joins(:trip).
      where('stop_id = :stop_id and departure_time >= :departure_time and trips.timeframe_id in (:timeframes)', {
        stop_id: stop.id,
        departure_time: self.current_time,
        timeframes: current_timeframes
      }).
      limit(10).
      order('departure_time').
      includes(:trip => [:route])
  end

  def parsed_departure_time
    departure_time = '%06d' % self.departure_time
    hour = departure_time[0,2].to_i
    day = (hour / 24).truncate
    hour = hour % 24
    min = departure_time[2,2].to_i
    sec = departure_time[4,2].to_i
    parsed_time = Time.now.change hour: hour, min: min, sec: sec
    parsed_time + day.day
  end

  private

  def self.parse_time departure
    departure.split(':').join('').to_i
  end

  private

  def self.current_time
    Time.now.strftime '%H%M%S'
  end

end
