require 'pry'



class Trip
  MAX_POINTS_PER_GOOGLE_MAP = 20
    
  def initialize(locations)
    @locations = locations
    @start = locations.first
    @end = locations.last    
  end
  
  def total_time
    @end.time_difference_between_location(@start)  
  end

  def total_distance
    @end.distance_from_location(@start)  
  end

  def google_maps_url
    point_intervals = @locations.length / MAX_POINTS_PER_GOOGLE_MAP    
    point_intervals = point_intervals > 0 ? point_intervals : 1
  
    locations_to_plot = (0...@locations.length).step(point_intervals).map do |index|
      @locations[index]      
    end.push(@end)

    self.create_url_from_locations(locations_to_plot)
  end

  def create_url_from_locations(locations)
    start_coordinates = @start.coordinates_as_string
    destinations_string = locations.map do |location|
      location.coordinates_as_string
    end.join('+to:')

    # TODO don't do this
    "https://maps.google.com/maps?source=s_d&saddr=#{@start.coordinates_as_string}&daddr=#{destinations_string}&dirflg=w"
  end
end