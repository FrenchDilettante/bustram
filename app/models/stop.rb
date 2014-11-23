class Stop < ActiveRecord::Base

  has_many :locations

  def self.import line
    stop = Stop.new

    parts = line.split ','
    stop.code = parts[0]
    stop.name = parts[2][1, parts[2].length-2].split.map(&:capitalize).join ' '

    stop
  end

end
