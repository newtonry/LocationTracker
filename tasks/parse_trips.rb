require 'pry'

require 'geocoder'




require './models/location_coordinates.rb'
require './models/trip.rb'


locs = LocationCoordinates.fetch_all






trips = Trip.generate_from_locations(locs)





# trip.google_maps_url




binding.pry