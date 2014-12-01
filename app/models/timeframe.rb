class Timeframe < ActiveRecord::Base

  def self.current_weekday
    Time.now.strftime('%A').downcase
  end

  def self.current_timeframes
    self.where("current_date >= start_date and current_date <= end_date and #{self.current_weekday} = true")
  end

  def self.import line
    parts = line.split ','

    timeframe = Timeframe.new

    timeframe.code = parts[0]

    timeframe.monday = parts[1] == '1'
    timeframe.tuesday = parts[2] == '1'
    timeframe.wednesday = parts[3] == '1'
    timeframe.thursday = parts[4] == '1'
    timeframe.friday = parts[5] == '1'
    timeframe.saturday = parts[6] == '1'
    timeframe.sunday = parts[7] == '1'

    format = '%Y%m%d'
    timeframe.start_date = Date.strptime parts[8], format
    timeframe.end_date = Date.strptime parts[9], format

    timeframe.save!

    timeframe
  end

end
