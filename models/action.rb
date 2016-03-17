require './db/environment.rb'  # need for db settings. eventually want to auto-load this probably
require './constants'


class Action < ActiveRecord::Base

  has_many :location_coordinates, class_name: 'LocationCoordinates'
  belongs_to :user


  VISIT_DISTANCE_MAX = 1000  # Number of meters in which something should be considered the same location or not
  MINIMUM_TIME = 15  # Number of minutes which a user must stay within the location for it to be considered a visit

  def self.from_location_coordinates(location_coordinates)
    # Setting all the 'next' location coordinates. Similar to a linked list
    location_coordinates.each_with_index do |location, index|
      location.set_next_location_coordinates(location_coordinates[index + 1])
    end
    
    clusters = []
    travel_cluster = []  # the travel cluster is meant to hold locations that aren't close enough to each other and keep on adding to it until we hit a visit, in which case we know travel is done
    
    index = 0
    while index < location_coordinates.length
      current_location = location_coordinates[index]      
      visit_cluster = self.get_visit_locations_from_location(current_location)
      
      if visit_cluster
        clusters << travel_cluster if travel_cluster.length > 0
        travel_cluster = []
        
        clusters << visit_cluster
        index += visit_cluster.length
        
      else
        # If the current_location does not have following locations that make up a visit, it must be travel
        travel_cluster << current_location        
        index += 1        
      end
    end
    clusters << travel_cluster if travel_cluster.length > 0
    
    self.save_actions_from_clusters(clusters)
  end
  
  def self.get_visit_locations_from_location(location)
    # Gets the location coordinates that make up a visit action if there is one. Otherwise we return nothing.
    cluster = [location]
    # Keep adding next locations until we're out of range.
    while cluster.last.get_next_location_coordinates and self.cluster_is_within_action_distance?(cluster + [cluster.last.get_next_location_coordinates])
      cluster << cluster.last.get_next_location_coordinates
    end
    return self.is_a_visit_cluster?(cluster) ? cluster : nil
  end
  
  
  def self.save_actions_from_clusters(clusters)
    # Creates action objects from clusters and returns them
    
    clusters.map do |cluster|
      action_type = self.is_a_visit_cluster?(cluster) ? LocationCoordinatesActionType.VISIT : LocationCoordinatesActionType.TRAVEL
      # TODO we're making the bad assumption that all the location coordinates we're passing in are from the same user      
      user_id = cluster.last.user_id      
      action = Action.create(type_index: action_type[:index], user_id: user_id)
      action.location_coordinates = cluster
      action
    end
  end
  
  def self.is_a_visit_cluster?(cluster)
    cluster.first.time_between(cluster.last) >= MINIMUM_TIME and self.cluster_is_within_action_distance?(cluster) 
  end
  
  def self.cluster_is_within_action_distance?(cluster)
    # TODO could reduce this time by just comparing first and last
    
    starting_location = cluster[0]
    cluster[1..cluster.length-1].each do |location|
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
  
  def midpoint
    lat = 0
    lng = 0
    self.location_coordinates.each do |location|
      lat += location.lat
      lng += location.lng      
    end
    lat = lat / self.location_coordinates.count
    lng = lng / self.location_coordinates.count    
    require './models/location_coordinates'
    LocationCoordinates.new(lat: lat, lng: lng)    
  end
  
  def start_with_venues_and_types
    # Work this out with ActiveRecord later. It's just being used in server responses
    self.start.as_json(include: [:google_places, :types, :yelp_businesses])
  end

  def finish
    self.location_coordinates.last
  end

  def finish_with_venues_and_types
    # Work this out with ActiveRecord later. It's just being used in server responses
    self.finish.as_json(include: [:google_places, :types, :yelp_businesses])
  end

  def location_coordinates_count
    # Just here to include in json data for now
    self.location_coordinates.count
  end

  def time_taken
    self.start.time_between(self.finish)
  end
end
