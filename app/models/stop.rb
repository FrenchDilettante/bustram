class Stop < ActiveRecord::Base

  has_many :locations

  def self.import line
    parts = line.split ','
    parsed_name = parts[2][1, parts[2].length-2].split.map(&:capitalize).join ' '

    stop = Stop.find_by_name parsed_name
    if stop.nil?
      stop = Stop.new
    end

    location = Location.new

    stop.name = parsed_name

    location.code = parts[0]
    location.lat = parts[4]
    location.lon = parts[5]
    stop.locations << location

    stop.save!
    location.save!

    stop
  end

end
