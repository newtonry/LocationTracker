require './db/environment'  # need for db settings. eventually want to auto-load this probably


class User < ActiveRecord::Base
  has_many :location_coordinates, class_name: 'LocationCoordinates'
  has_many :actions
  has_many :trips
end

