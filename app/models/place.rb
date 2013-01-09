class Place < ActiveRecord::Base
  attr_accessible :latitude, :longitude

  has_many :trip_places
  has_many :trips, through: :trip_places

  #geocoded_by :name
  #reverse_geocoded_by :latitude, :longitude do |obj, results|
    #geo = results.first
    #if geo && !geo.data["partial_match"]
      #obj.name = geo.city
    #else
      #obj.errors[:name] = "#{obj.name} not found"
    #end
  #end
  #after_validation :geocode, :reverse_geocode, if: ->(obj) { obj.name_changed? }
end
