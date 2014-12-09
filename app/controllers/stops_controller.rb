class StopsController < ApplicationController

  def show
    @stop = Stop.friendly.find params[:id]
  end

end
