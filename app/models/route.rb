class Route < ActiveRecord::Base

  def self.import line
    route = Route.new

    parts = line.split ','
    route.code = parts[0]
    route.short_name = parts[1]
    route.long_name = self.parse_route_name parts[2]
    route.transport_type = self.parse_transport_type parts[4]

    route.save!

    route
  end

  private

  def self.parse_route_name name
    name[1, name.length-2].split.join ' '
  end

  def self.parse_transport_type type_id
    type_id == '3' ? 'B' : 'T'
  end

end
