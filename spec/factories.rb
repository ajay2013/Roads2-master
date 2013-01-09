# encoding: UTF-8

FactoryGirl.define do
  factory :user do
    email { Faker::Internet::email }
    password "password"
    password_confirmation "password"
  end

  factory :place do
    latitude { rand(-90.0..90.0) }
    longitude { rand(-180.0..180.0) }
  end

  factory :trip_place do
    place_name { Faker::Address::city }
  end

  factory :trip do
    trip_name Faker::Lorem::sentence
    description Faker::Lorem::paragraph
    trip_date Date.today
    transport Trip::TRANSPORT.sample
    trip_places Array.new(3) { FactoryGirl.create(:trip_place) }
  end

  factory :invalid_trip, parent: :trip do |trip|
    trip.trip_name nil
  end
end
