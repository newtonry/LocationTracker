require './models/location_coordinates.rb'
require './models/action.rb'


def create_actions_from_locations!
  Action.destroy_all
  location_coordinates = LocationCoordinates.all
  Action.from_location_coordinates(location_coordinates)
  p "Action creation finished"
end

create_actions_from_locations!