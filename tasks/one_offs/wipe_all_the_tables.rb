require './models/action.rb'
require './models/google_place.rb'
require './models/location_coordinates.rb'
require './models/trip.rb'
require './models/type.rb'
require './models/user.rb'
require './models/yelp_business.rb'

def wipe_all_the_tables!
  # This is super dangerous!
  Action.destroy_all
  GooglePlace.destroy_all
  LocationCoordinates.destroy_all
  Trip.destroy_all
  Type.destroy_all
  User.destroy_all
  YelpBusiness.destroy_all
  puts "All the tables have been deleted"
end
