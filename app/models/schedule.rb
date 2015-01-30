class Schedule < ActiveRecord::Base
  belongs_to :location
  belongs_to :stop
  belongs_to :trip

  def self.import line, location_ids, stop_ids, trip_ids
    parts = line.split ','

    ActiveRecord::Base.connection.execute "
      INSERT INTO schedules (
        location_id,
        stop_id,
        trip_id,
        departure_time,
        stop_sequence
      )
      VALUES (
        #{location_ids[parts[3]]},
        #{stop_ids[parts[3]]},
        #{trip_ids[parts[0]]},
        #{self.parse_time(parts[2])},
        #{parts[4].to_i}
      )
    "
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
