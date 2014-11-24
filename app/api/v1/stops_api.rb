module V1
  class StopsApi < Grape::API
    version 'v1'
    format :json

    module Entities
      class Stop < Grape::Entity
        expose :slug, as: :id
        expose :name
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
