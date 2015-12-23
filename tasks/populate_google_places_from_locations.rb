require './models/location_coordinates'


def populate_google_places_from_locations
  x = LocationCoordinates.first
  y = x.fetch_and_create_places
  
end



populate_google_places_from_locations