class Action

  VISIT_DISTANCE_MAX = 250  # Number of meters in which something should be considered the same location or not
  MINIMUM_TIME = 5  # Number of minutes which a user must stay within the location for it to be considered a visit

  def self.from_location_coordinates(location_coordinates)
    
    clusters = []
    current_cluster = []
    
    location_coordinates.each do |location|
      
      
    end
  end

  def cluster_is_within_action_distance(cluster)
    cluster[0...cluster.length-1].each_with_index do |location, index|
    end
  end
end
