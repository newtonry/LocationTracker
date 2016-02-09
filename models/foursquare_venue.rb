require './db/environment'  # need for db settings. eventually want to auto-load this probably

require 'json'
require 'rest-client'
require './api_keys'
require './models/type'


class FoursquareVenue < ActiveRecord::Base
  FOURSQUARE_VENUES_BASE_URL = 'https://api.foursquare.com/v2/venues/search'
  FOURSQUARE_API_VERSION = 20130815
  RADIUS = 25
  INTENT = 'browse'

  def self.url_for_lat_long(lat, lng)
    location_str = [lat, lng].join(',')
    FOURSQUARE_VENUES_BASE_URL + "?client_id=#{FOURSQUARE_KEYS[:CLIENT_ID]}&client_secret=#{FOURSQUARE_KEYS[:CLIENT_SECRET]}&v=#{FOURSQUARE_API_VERSION}&ll=#{lat},#{lng}&intent=#{INTENT}&radius=#{RADIUS}"
  end

  def self.fetch_for_location_coordinates(location_coordinates)    
    response = RestClient.get(self.url_for_lat_long(location_coordinates.lat, location_coordinates.lng))
    JSON.parse(response)
  end
end
