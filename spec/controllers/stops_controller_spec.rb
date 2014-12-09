require 'rails_helper'

RSpec.describe StopsController, :type => :controller do

  describe 'show' do
    stop = nil
    before(:each) do
      stop = Stop.create name: 'test'
      get :show, id: stop.slug
    end

    it 'should render the stop' do
      expect(response.code).to eq('200')
      expect(assigns(:stop)).to eq(stop)
    end
  end

end
