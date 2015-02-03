class Route < ActiveRecord::Base

  def self.import line
    route = Route.new

    parts = line.split ','
    route.code = parse_code parts[0]
    route.short_name = parts[1]
    route.long_name = self.parse_route_name parts[2]
    route.transport_type = self.parse_transport_type parts[4]
    route.sub_route = @sub_route_regex.match(route.code) != nil

    route.save!

    route
  end

  private

  def self.parse_code code
    code[1, code.length]
  end

  def self.parse_route_name name
    name[2, name.length-4].split.join ' '
  end

  def self.parse_transport_type type_id
    type_id == '3' ? 'B' : 'T'
  end

  @sub_route_regex = /\d+(s|d)/

end
