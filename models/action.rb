class Action

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
    
    clusters.each do |cluster|
      p self.is_a_visit_cluster?(cluster)
    end
    
    
    clusters
    
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
end
