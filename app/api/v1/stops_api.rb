module V1
  class StopsApi < Grape::API
    version 'v1'
    format :json

    module Entities
      class Location < Grape::Entity
        expose :code, as: :id
        expose :coordinates do
          expose :lat
          expose :lon
        end
      end

      class Stop < Grape::Entity
        expose :slug, as: :id
        expose :name
        expose :locations, using: V1::StopsApi::Entities::Location, as: :locations
      end
    end

    resource :stops do
      desc 'Return list of stops'

      get do
        present Stop.search(params[:name]), with: V1::StopsApi::Entities::Stop
      end
    end
  end
end
