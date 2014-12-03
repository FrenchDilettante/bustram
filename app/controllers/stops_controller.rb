class StopsController < ApplicationController

  def show
    @stop = Stop.friendly.find params[:id]
    @schedules = Schedule.next @stop
  end

end
