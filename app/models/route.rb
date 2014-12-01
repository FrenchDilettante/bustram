class Route < ActiveRecord::Base

  def self.import line
    route = Route.new

    parts = line.split ','
    route.code = parts[0]
    route.short_name = parts[1]
    route.long_name = self.parse_route_name parts[2]

    route.save!

    route
  end

  private

  def self.parse_route_name name
    name[1, name.length-2].split.join ' '
  end

end
