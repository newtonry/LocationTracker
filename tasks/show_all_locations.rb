# require 'pry'

require './models/trip.rb'
require './models/visit.rb'
require './models/location_coordinates.rb'
require './models/google_place.rb'


# def show_all_locations
#   location_coordinates = LocationCoordinates.fetch_all
#   location_names = Set.new
#
#   location_coordinates.each do |location_coordinate|
#     location_coordinate.get_places.each do |place|
#       location_names.add(place.name)
#     end
#   end
#
#   location_names
# end
#
# p show_all_locations

# x = GooglePlace.first
# x.number_of_location_coordinates

# require 'pry'
# binding.pry


# x = LocationCoordinates.first
# x.action

# Visit.destroy_all
# trip = Trip.last

# Visit.create_visits_from_location_coordinates(trip.location_coordinates)


# trip.create_visits

#
# Trip.all.each do |trip|
#   trip.create_visits
#   p trip.visits.count
# end
#

require 'pry'
binding.pry





# y = LocationCoordinates.last

# z = x.distance_from_location(y)

# binding.pry