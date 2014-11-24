module V1
  class StopsApi < Grape::API
    version 'v1'
    format :json

    resource :stops do
      desc 'Return list of stops'

      get do
        Stop.all
      end
    end
  end
end
