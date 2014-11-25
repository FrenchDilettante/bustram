module V1
  class StopsApi < Grape::API
    version 'v1'
    format :json

    rescue_from ActiveRecord::RecordNotFound do
      rack_response('{"message": "Not found", "status": 404}', 404)
    end

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
      params do
        requires :q, type: String, regexp: /.{3,}/, desc: 'q must have at least 3 characters'
      end
      get do
        present Stop.search(params[:q]), with: V1::StopsApi::Entities::Stop
      end

      desc 'Return a stop'
      params do
        requires :id, type: String, desc: 'Stop id is required'
      end
      get ':id' do
        present Stop.friendly.find(params[:id]), with: V1::StopsApi::Entities::Stop
      end

    end
  end
end
