module TripsHelper
  def my_trip?(trip)
    trip.user == current_user
  end

  def short_date(trip)
    trip.trip_date.strftime("%b %Y")
  end
end
