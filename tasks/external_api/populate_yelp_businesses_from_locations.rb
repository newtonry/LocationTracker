require './models/action'
require './models/location_coordinates'
require './constants'

def populate_yelp_businesses_from_locations(locations)
  locations = locations or LocationCoordinates.all.reverse

  p "Starting to create Yelp Businesses for #{locations.count} locations."

  locations.each do |location|
    if location.yelp_businesses.count == 0  # just filtering this way for now b/c we're running out of google api calls :(
      location.fetch_and_create_yelp_businesses
    end
  end
  p "Finished populating yelp businesses."
end


def populate_yelp_businesses_for_action_visit_finishes
  finishes = Action.where(type_index: LocationCoordinatesActionType.VISIT[:index]).map do |action|
    action.finish
  end
  populate_yelp_businesses_from_locations(finishes)
end


populate_yelp_businesses_for_action_visit_finishes
