require './models/action.rb'
require './models/trip.rb'
require './models/user.rb'



def generate_trips_and_actions_for_user(user)
  # This will render all actions, trips, interests etc for a particular user. All that we need is the LocationCoordinates to already be out of parse and in our SQL db.
  # I'm going to assume that the most recent without a trip_id and action_id is the watermark for when we last touched them. Because all LocationCoordinates should eventually be part of an action as well as trip.  
  
  puts "Starting to generate trips and actions for #{user.username}"

  actionless_location_coordinates = user.location_coordinates.where(action_id: nil).order('time_visited ASC')
  Action.from_location_coordinates(actionless_location_coordinates)
  puts "Action creation finished. There are now #{user.actions.count} total actions for #{user.username}"
  
  tripless_location_coordinates = user.location_coordinates.where(trip_id: nil).order('time_visited ASC')
  Trip.create_from_locations(tripless_location_coordinates)
  puts "Trip creation finished. There are now #{user.trips.count} total trips for #{user.username}"
end

def generate_trips_and_actions_for_all_users
  puts "...Starting to trips and actions for all users..."
  User.all.each do |user|
    generate_trips_and_actions_for_user(user)
  end
  puts "...Finished generating trips and actions for all users..."
end

generate_trips_and_actions_for_all_users