#  TODO this task should probably never be run again

require './models/location_coordinates.rb'
require './models/trip.rb'

def destroy_all_and_create_trips_from_all_locations!
  Trip.destroy_all
  Trip.create_from_locations(LocationCoordinates.all.order('time_visited ASC'))
  p "Trips created! There are now #{Trip.count} trips"
end


destroy_all_and_create_trips_from_all_locations!