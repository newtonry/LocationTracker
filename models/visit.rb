# require './db/environment.rb'  # need for db settings. eventually want to auto-load this probably
#
# class Visit < ActiveRecord::Base
#   belongs_to :trip
#   has_many :location_coordinates, class_name: 'LocationCoordinates'
#
#   VISIT_DISTANCE_MAX = 250  # Number of meters in which something should be considered the same location or not
#   MINIMUM_TIME = 5  # Number of minutes which a user must stay within the location for it to be considered a visit
#
#
#   def self.create_visits_from_location_coordinates(location_coordinates)
#     visits = []
#     current_locations_set = []  # Represents a set of locations to determine if it's a visit or not
#     current_visit = nil
#
#     # TODO this seems way too complex. Prob should refactor
#     location_coordinates.each do |location|
#       current_locations_set << location
#       if location_coordinates_all_within_visit_distance?(current_locations_set)
#         if self.location_coordinates_longer_than_minimum_time?(current_locations_set)
#           current_visit = current_visit ? current_visit : self.create()
#           current_visit.location_coordinates = current_locations_set
#           current_visit.save()
#         end
#       else
#         if current_visit
#           visits << current_visit
#         end
#         current_locations_set = []
#         current_visit = nil
#       end
#     end
#     if current_visit  # TODO so dumb repeating this, definitely needs a refactor
#       visits << current_visit
#     end
#
#     visits
#   end
#
#   def self.location_coordinates_longer_than_minimum_time?(location_coordinates_set)
#     location_coordinates_set.first.time_between(location_coordinates_set.last) >= MINIMUM_TIME
#   end
#
#   def self.location_coordinates_all_within_visit_distance?(location_coordinates_set)
#     # Takes a full set. If any of the points are more than VISIT_DISTANCE_MAX apart, it's not a trip
#     location_coordinates_set.each do |location|
#        return false if location_coordinates_set.first.distance_from(location) > VISIT_DISTANCE_MAX
#      end
#      true
#   end
# end