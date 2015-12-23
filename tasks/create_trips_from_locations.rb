require 'pry'
require 'geocoder'
require './models/location_coordinates.rb'
require './models/trip.rb'
require './models/type.rb'


def generate_from_locations(locations)
  trips = []




  LocationCoordinates.all do |location|
    
    
    
    if trips.length > 0 and trips.last.end.time_difference_between_location(location) < MAX_TIME_DIFF_BETWEEN_PINGS
      trips.last.add_location(location)
    else
      trips << self.new([location])
    end
  end
  
  return trips
end




binding.pry




# trip.google_maps_url




