module V1
  module Entities
    class Location < Grape::Entity
      expose :code, as: :id
      expose :coordinates do
        expose :lat
        expose :lon
      end
    end

    class Route < Grape::Entity
      expose :short_name, as: :id
      expose :long_name, as: :name
      expose :type do |route|
        route.transport_type == 'B' ? 'bus' : 'tramway'
      end
    end

    class Schedule < Grape::Entity
      expose :departure_time do |schedule|
        schedule.parsed_departure_time
      end
      expose :route_id do |schedule|
        schedule.trip.route.short_name
      end
      expose :headsign do |schedule|
        schedule.trip.headsign
      end
    end

    class Stop < Grape::Entity
      expose :slug, as: :id
      expose :name
    end

    class FullStop < Stop
      expose :locations, using: Location, as: :locations
    end
  end
end
