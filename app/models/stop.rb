class Stop < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :locations

  def self.import line
    parts = line.split ','
    parsed_name = parts[2][1, parts[2].length-2].split.map(&:capitalize).join ' '

    stop = Stop.find_by_name parsed_name
    if stop.nil?
      stop = Stop.new
      stop.name = parsed_name
      stop.save!
    end

    location = Location.new

    location.code = parts[0]
    location.lat = parts[4]
    location.lon = parts[5]
    stop.locations << location

    location.save!

    stop
  end

  def self.search name
    if name.blank?
      self.all
    else
      self.where 'slug like :name', name: "%#{name.parameterize}%"
    end
  end

end
