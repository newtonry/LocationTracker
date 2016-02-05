# Just going to be using this for testing out action stuff

require './models/action.rb'
require './models/location_coordinates.rb'

Action.destroy_all
LocationCoordinates.update_all(action_id: nil)

puts "All action data wiped"