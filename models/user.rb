require './db/environment'  # need for db settings. eventually want to auto-load this probably
require './models/location_coordinates'


class User < ActiveRecord::Base
  has_many :location_coordinates, class_name: 'LocationCoordinates'
  has_many :actions
  has_many :trips

  def location_coordinates_count
    self.location_coordinates.count
  end

  def actions_count
    self.actions.count
  end

  def trips_count
    self.trips.count
  end
end

