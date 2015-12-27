require './db/environment.rb'  # need for db settings. eventually want to auto-load this probably
require './constants'


class Action < ActiveRecord::Base

  has_many :location_coordinates, class_name: 'LocationCoordinates'
  

  VISIT_DISTANCE_MAX = 250  # Number of meters in which something should be considered the same location or not
  MINIMUM_TIME = 5  # Number of minutes which a user must stay within the location for it to be considered a visit

  def self.from_location_coordinates(location_coordinates)
    
    clusters = []
    current_cluster = []
    
    location_coordinates.each_with_index do |location, index|
      location.set_next_location_coordinates(location_coordinates[index + 1])
    end
    
    
    location_coordinates.each do |location|
      if cluster_is_within_action_distance(current_cluster + [location])
        current_cluster << location  # The current location is part of the cluster, so lets keep going
      else
        clusters << current_cluster
        current_cluster = [location]
      end
    end
    
    # So now we'll clusters of items next to each other. it will look like [[travel_node, travel_node], [travel_node], [visit, visit], [travel_node], [visit]]
    # Need to process them
    
    self.save_actions_from_clusters(clusters)
  end
  
  def self.save_actions_from_clusters(clusters)
    # Combines adjacent travel clusters and creates both visit and en route ones
    travel_cluster_stack = []
    clusters.each do |cluster|
      if self.is_a_visit_cluster?(cluster)
        # Clear the en route stack if there is one
        if travel_cluster_stack
          action = Action.create(type_index: LocationCoordinatesActionType.TRAVEL[:index])
          action.location_coordinates = travel_cluster_stack
        end

        action = Action.create(type_index: LocationCoordinatesActionType.VISIT[:index])
        action.location_coordinates = cluster
      else
        travel_cluster_stack += cluster
      end
    end
  end
  
  def self.is_a_visit_cluster?(cluster)
    if cluster.last.time_between(cluster.last.get_next_location_coordinates) > MINIMUM_TIME
      # If it's the last ping for a while, we can probably assume that it's the final stop because the GPS ended.
      # Right now this is valid, b/c we only ping when the user moves 30 meters or more. May want to remove this qualification later
      return true
    end
    if cluster.first.time_between(cluster.last) >= MINIMUM_TIME and self.cluster_is_within_action_distance(cluster) 
      return true
    end
    false
  end
  
  def self.cluster_is_within_action_distance(cluster)
    # TODO could reduce this time by just comparing first and last
    
    starting_location = cluster[0]
    cluster[1...cluster.length-1].each do |location|
      return false if starting_location.distance_from(location) > VISIT_DISTANCE_MAX
    end
    true
  end
  
  def type
    LocationCoordinatesActionType.from_index(self.type_index)
  end
  
  def start
    self.location_coordinates.first
  end

  def finish
    self.location_coordinates.last
  end

  def time_taken
    self.start.time_between(self.finish)
  end
end
