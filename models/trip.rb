require './db/environment.rb'  # need for db settings. eventually want to auto-load this probably


class Trip < ActiveRecord::Base
  MAX_POINTS_PER_GOOGLE_MAP = 20
  MAX_TIME_DIFF_BETWEEN_PINGS = 15  # if the last ping was more than 15 mins, it's probably a different trip
  
  has_many :location_coordinates, class_name: 'LocationCoordinates'
  belongs_to :user
  
  def self.create_from_locations(locations)
    trips = []

    locations.each do |location|
      # create a new trip if there are none or the ping between the last loc was more than 15 mins
      
      # TODO we're making a bad assumption here, that all the given locations are from the same user
      trips << self.create(user_id: location.user_id) if (trips.length == 0 or trips.last.finish.time_between(location) > MAX_TIME_DIFF_BETWEEN_PINGS)
      trips.last.location_coordinates << location
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
    self.total_time = finish.time_between(start)
  end

  def update_total_distance
    self.total_distance = finish.distance_from(start)  
  end

  def update_total_time!
    self.update_total_time
    self.save
  end

  def update_total_distance!
    self.update_total_distance
    self.save
  end
end