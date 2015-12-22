require 'active_record'
require 'sqlite3'
require './models/location_coordinates.rb'
# require './db/environment.rb'

require 'pry'

# # tells AR what db file to use
# ActiveRecord::Base.establish_connection(
#   :adapter => 'sqlite3',
#   :database => 'db/location-tracker.db'
# )



# class LocationCoordinates < ActiveRecord::Base
#   # self.table_name = "location_coordinates"
#
#
#   attr_accessor :time_visited, :lat, :lng
#   # before_save :stuff
#   #
#   # def stuff
#   #   binding.pry
#   # end
#
#   # def initialize(time_visited=nil, lat=nil, lng=nil)
#   #   @time_visited = time_visited
#   #   @lat = lat
#   #   @lng = lng
#   # end
# end

# LocationCoordinates.fetch_all



# x = LocationCoordinates.new
# # ({
# #   lat: 3,
# #   lng: 3,
# #   time_visited: 2
# # })
# x.lat = 3
# x.lng = 3
# x.time_visited = 10
# #
# # binding.pry
#
# x.save
#

# x = LocationCoordinates.create(lat: 1, lng: 2, time_created: 3)
# x.save()



# db = SQLite3::Database.new( "db/location-tracker.db" )




locs = LocationCoordinates.fetch_all_from_parse
locs.each do |loc|
  loc.save!


  # if LocationCoordinates.find_by(parse_id: loc.parse_id)
  #   loc.save!
  # end
end
    


binding.pry