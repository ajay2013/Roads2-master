class TripPlace < ActiveRecord::Base
  belongs_to :trip
  belongs_to :place
  attr_accessible :place_name, :trip_id, :place_id

  default_scope order: "id"

  def self.create_from_hash(trip_id, hash)
    new_trip_place = self.new(trip_id: trip_id, place_name: hash[:name])

    place = Place.find_by_latitude_and_longitude(hash[:lat], hash[:lon])
    if place
      new_trip_place.place_id = place.id
    else
      place = Place.new(latitude: hash[:lat], longitude: hash[:lon])
      place.save
      new_trip_place.place_id = place.id
    end

    new_trip_place.save
    new_trip_place
  end
end
