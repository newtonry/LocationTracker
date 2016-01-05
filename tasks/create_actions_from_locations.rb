require './models/location_coordinates.rb'
require './models/action.rb'


def create_actions_from_locations!
  Action.destroy_all
  location_coordinates = LocationCoordinates.all.order('time_visited ASC')
  Action.from_location_coordinates(location_coordinates)
  p "Action creation finished. There are now #{Action.count} total actions."
end

create_actions_from_locations!