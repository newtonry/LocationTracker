require 'json'
require 'rest-client'
require './api_keys'


class GooglePlace
  GOOGLE_PLACES_BASE_URL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
  DEFAULT_RADIUS = 10
  
  attr_accessor :name 

  def self.url_for_long_lat(long, lat)
    location_str = [long, lat].join(',')
    GOOGLE_PLACES_BASE_URL + "?location=#{location_str}&radius=#{DEFAULT_RADIUS}&key=#{GOOGLE_PLACES_CLIENT_KEY}"
  end

  def self.fetch_places_for_coordinates(long, lat)
    response = RestClient.get(self.url_for_long_lat(long, lat))
    
    JSON.parse(response)['results'].map do |json_google_place|
      self.init_from_json(json_google_place)
    end
  end
  
  def self.init_from_json(json)
    self.new(json['id'], json['name'], json['types'])
  end

  def initialize(id, name, types)
    @id = id
    @name = name
    @types = types
  end
  
end