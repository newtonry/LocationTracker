require './models/location_coordinates.rb'
require './models/trip.rb'
# require './models/visit.rb'

def destroy_all_and_create_trips_from_all_locations!
  Trip.destroy_all
  # Visit.destroy_all
  Trip.create_from_locations(LocationCoordinates.all)
  p "Trips created! There are now #{Trip.count} trips"
end


destroy_all_and_create_trips_from_all_locations!