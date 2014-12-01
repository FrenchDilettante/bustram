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
