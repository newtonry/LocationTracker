require 'pry'



class Trip
  MAX_POINTS_PER_GOOGLE_MAP = 20
  MAX_TIME_DIFF_BETWEEN_PINGS = 15  # if the last ping was more than 15 mins, it's probably a different trip
  
  attr_accessor :locations, :end
    
    
    
  def self.generate_from_locations(locations)
    trips = []
    
    # binding.pry
    
    locations.each do |location|
      if trips.length > 0 and trips.last.end.time_difference_between_location(location) < MAX_TIME_DIFF_BETWEEN_PINGS
        trips.last.add_location(location)
      else
        trips << self.new([location])
      end
    end
    
    return trips
  end
    
  def initialize(locations)
    @locations = locations
    @start = locations.first
    @end = locations.last    
  end
  
  def to_hash
    {
      start: @start.to_hash,
      end: @end.to_hash,
      total_time: self.total_time,
      # total_distance: self.total_distance,
      locations: locations.map {|location| location.to_hash}
    }
  end
  
  def add_location(location)
    @locations << location
    @end = location
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
    # TODO this can be on itself now, dont need to pass em in, or it could be a class method
    start_coordinates = @start.coordinates_as_string
    destinations_string = locations.map do |location|
      location.coordinates_as_string
    end.join('+to:')

    # TODO don't do this
    "https://maps.google.com/maps?source=s_d&saddr=#{@start.coordinates_as_string}&daddr=#{destinations_string}&dirflg=w"
  end
end