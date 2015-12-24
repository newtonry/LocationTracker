require 'pry'

require 'set'
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


x = LocationCoordinates.first
y = LocationCoordinates.last

z = x.distance_from_location(y)

binding.pry