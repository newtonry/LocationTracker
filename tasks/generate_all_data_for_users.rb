require 'active_record'
require 'sqlite3'
require './models/location_coordinates.rb'




def generate_all_new_data_for_user(user)
  # This will render all actions, trips, interests etc for a particular user. All that we need is the LocationCoordinates to already be out of parse and in our SQL db.
  # I'm going to assume that the most recent without a trip_id and action_id is the watermark for when we last touched them. Because all LocationCoordinates should eventually be part of an action as well as trip.
  
  location_coordinates = user.location_coordinates.where(action_id: nil, trip_id: nil)
  
  
  
  
  
  
  
  
  
end


