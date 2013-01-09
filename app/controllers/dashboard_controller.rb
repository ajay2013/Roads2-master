class DashboardController < ApplicationController
before_filter :authenticate_user!

  def index    
    @my_trips = Trip.scoped_by_user_id(current_user.id)
  end
end
