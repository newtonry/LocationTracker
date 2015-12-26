require './db/environment.rb'  # need for db settings. eventually want to auto-load this probably
require './models/visit.rb'

class Trip < ActiveRecord::Base
  MAX_POINTS_PER_GOOGLE_MAP = 20
  MAX_TIME_DIFF_BETWEEN_PINGS = 15  # if the last ping was more than 15 mins, it's probably a different trip
  
  has_many :visits
  has_many :location_coordinates, class_name: 'LocationCoordinates'
  
  
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
      trip.create_visits
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
  
  def create_visits
    self.visits = Visit.create_visits_from_location_coordinates(self.location_coordinates)
  end
end