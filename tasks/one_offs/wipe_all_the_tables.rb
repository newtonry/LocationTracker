require './models/trip.rb'
require './models/location_coordinates.rb'
require './models/google_place.rb'
require './models/action.rb'


def wipe_all_the_tables!
  # This is super dangerous!
  Trip.all.delete()
  Action.all.delete()
  LocationCoordinates.all.delete()
  GooglePlace.all.delete()
  User.all.delete()
  puts "All the tables have been deleted"
end