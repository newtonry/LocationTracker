require './models/action'
require './models/location_coordinates'
require './constants'

def populate_google_places_from_locations(locations)
  locations = locations or LocationCoordinates.all.reverse
  
  p "Starting to create Google Places for #{locations.count} locations."
  
  locations.each do |location|
    if location.google_places.count == 0  # just filtering this way for now b/c we're running out of google api calls :(
      location.fetch_and_create_places
    end
  end
  
  p "Finished populating google places."
end

def populate_google_places_for_action_visit_finishes
  finishes = Action.where(type_index: LocationCoordinatesActionType.VISIT[:index]).map do |action|
    action.finish
  end
  populate_google_places_from_locations(finishes)
end


populate_google_places_for_action_visit_finishes
