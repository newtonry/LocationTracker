require 'pry'



class Trip < ActiveRecord::Base
  MAX_POINTS_PER_GOOGLE_MAP = 20
  MAX_TIME_DIFF_BETWEEN_PINGS = 15  # if the last ping was more than 15 mins, it's probably a different trip
  
  has_many :location_coordinates, class_name: 'LocationCoordinates'
  
  
  # attr_accessor :locations, :end
  def self.create_from_locations(locations)
    trips = []

    locations.each do |location|
      # create a new trip if there are none or the ping between the last loc was more than 15 mins
      
      trips << self.create if (trips.length == 0 or trips.last.finish.time_difference_between_location(location) > MAX_TIME_DIFF_BETWEEN_PINGS)
      trips.last.location_coordinates.push(location)
      trips.last.save()
    end
    
    trips.each do |trip|
      trip.update_total_time!
      trip.update_total_distance!
    end
    trips
  end
  
  def start
    self.location_coordinates.first
  end
  
  def finish
    self.location_coordinates.last  
  end
  
  def update_total_time    
    self.total_time = finish.time_difference_between_location(start)
  end

  def update_total_distance
    self.total_distance = finish.distance_from_location(start)  
  end

  def update_total_time!
    self.update_total_time
    self.save
  end

  def update_total_distance!
    self.update_total_distance
    self.save
  end
  #
  # def google_maps_url
  #   point_intervals = @locations.length / MAX_POINTS_PER_GOOGLE_MAP
  #   point_intervals = point_intervals > 0 ? point_intervals : 1
  #
  #   locations_to_plot = (0...@locations.length).step(point_intervals).map do |index|
  #     @locations[index]
  #   end.push(@end)
  #
  #   self.create_url_from_locations(locations_to_plot)
  # end
  #
  # def create_url_from_locations(locations)
  #   # TODO this can be on itself now, dont need to pass em in, or it could be a class method
  #   start_coordinates = @start.coordinates_as_string
  #   destinations_string = locations.map do |location|
  #     location.coordinates_as_string
  #   end.join('+to:')
  #
  #   # TODO don't do this
  #   "https://maps.google.com/maps?source=s_d&saddr=#{@start.coordinates_as_string}&daddr=#{destinations_string}&dirflg=w"
  # end
end