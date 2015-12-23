require './models/location_coordinates'


def populate_google_places_from_locations
  LocationCoordinates.all.each do |location|
    location.fetch_and_create_places
  end
end




def test
  LocationCoordinates.all.each do |location|
    if location.google_places.count == 0
      p location.id
    
    end
    
  end
end



# populate_google_places_from_locations



test