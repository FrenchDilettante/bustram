require 'rails_helper'

RSpec.describe StopsController, :type => :controller do

  describe 'GET /stops.json' do

    it 'should provide a list of stops' do
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

  end

end
