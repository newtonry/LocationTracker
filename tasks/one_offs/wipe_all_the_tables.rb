require './models/trip.rb'
require './models/location_coordinates.rb'
require './models/google_place.rb'
require './models/action.rb'


def wipe_all_the_tables!
  # This is super dangerous!
  Trip.destroy_all
  Action.destroy_all
  LocationCoordinates.destroy_all
  GooglePlace.destroy_all
  User.destroy_all
  puts "All the tables have been deleted"
end

wipe_all_the_tables!