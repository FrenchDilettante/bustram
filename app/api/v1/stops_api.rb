module V1
  class StopsApi < Grape::API
    version 'v1'
    format :json

    rescue_from ActiveRecord::RecordNotFound do
      rack_response('{"message": "Not found", "status": 404}', 404)
    end

    resource :stops do

      desc 'Return list of stops'
      params do
        optional :q, type: String, regexp: /.{3,}/, desc: 'q must have at least 3 characters'
      end
      get do
        stops = nil
        search_query = params[:q]

        if search_query.blank? or search_query.length < 3
          stops = Stop.all.includes :routes
        else
          stops = Stop.search search_query
        end
        present stops, with: V1::Entities::Stop
      end

      desc 'Return a stop'
      params do
        requires :id, type: String, desc: 'Stop id is required'
      end
      get ':id' do
        present Stop.friendly.find(params[:id]), with: V1::Entities::FullStop
      end

      desc 'return the next schedules'
      get ':id/schedules' do
        stop = Stop.friendly.find params[:id]
        present Schedule.next(stop), with: V1::Entities::Schedule
      end

    end
  end
end
