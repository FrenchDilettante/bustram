module V1
  class RoutesApi < Grape::API
    version 'v1'
    format :json

    resource :routes do

      desc 'return list of routes'
      get do
        present Route.all, with: V1::Entities::Route
      end

    end
  end
end
