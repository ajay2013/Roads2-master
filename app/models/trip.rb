class PlacesValidator < ActiveModel::Validator
  def validate(record)
    #TODO Why isn't size working?! No matter, probably will be validated on client side.
    if record.trip_places.length < 2
      record.errors[:base] = "You have to visit at least two places with a trip"
    end
  end
end

class Trip < ActiveRecord::Base
  TRANSPORT = %w(Car Motorbike Bicycle Bus Other)

  belongs_to :user
  attr_accessible :description, :trip_name, :trip_places, :user, :transport, :trip_date

  has_many :trip_places

  has_many :comments, :as => :commentable

  validates_presence_of :trip_name, :description, :trip_date
  validates :transport, presence: true, inclusion: { in: TRANSPORT, message: "%{value} is not considered transportation." }
  validates_with PlacesValidator
  
  def place_names
    trip_places.map(&:place_name)
  end

  def places
    trip_places.map do |trip_place|
      place = trip_place.place
      { "name" => trip_place.place_name, "lat" => place.latitude.to_s, "lon" => place.longitude.to_s }
    end
  end

  def add_trip_places(trip_places_hash)
    self.trip_places.delete_all
    trip_places_hash.each do |place|
      self.trip_places << TripPlace.create_from_hash(self.id, place)
    end
  end
end
