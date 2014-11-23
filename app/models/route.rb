class Route < ActiveRecord::Base

  def self.import line
    route = Route.new

    parts = line.split ','
    route.code = parts[0]
    route.short_name = parts[1]
    route.long_name = parts[2][1, parts[2].length-2].split.join ' '

    route.save!

    route
  end

end
