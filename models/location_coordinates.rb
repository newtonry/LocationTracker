require './db/environment.rb'  # need for db settings. eventually want to auto-load this probably

require 'geocoder'
require 'rest-client'
require './api_keys'
require './models/google_place.rb'


class LocationCoordinates < ActiveRecord::Base

  belongs_to :trip
  has_and_belongs_to_many :google_places
  has_many :types, through: :google_places
  
  
  PARSE_BASE_JS_URL = "https://#{PARSE_APP_ID}:javascript-key=#{PARSE_JS_KEY}@api.parse.com/1/classes/#{self.name}?limit=1000"
  PARSE_LIMIT = 1000  # TODO should go in constants file


  def self.parse_url    
    return PARSE_BASE_JS_URL
  end

  def self.fetch_all_from_parse
    json_results = []
  
    while true
      p self.parse_url + "&skip=#{json_results.length}"
      response = RestClient.get(self.parse_url + "&skip=#{json_results.length}")
      new_json_results = JSON.parse(response)['results']
      json_results += JSON.parse(response)['results']

      break if new_json_results.length == 0
    end

    json_results.map do |json_location_coordinate|
      self.init_from_json(json_location_coordinate)
    end
  end
  
  def self.init_from_json(json)
    lat, lng = json['location'].split(',')
    self.new(
      lat: Float(lat),
      lng: Float(lng),
      parse_id: json['objectId'],
      time_visited: DateTime.parse(json['createdAt'])
    )
  end
  
  def to_hash
    {
      coordinates: coordinates_as_string,  # TODO should just show both coords separately
      time_visited: self.time_visited
    }
  end
  
  def datetime
    DateTime.parse(self.time_visited)
  end
  
  def coordinates_as_string
    return "#{self.lat},#{self.lng}"    
  end
  
  def fetch_and_create_places
    self.google_places += GooglePlace.fetch_and_create_places_for_coordinates(self.lat, self.lng)
    self.save()
  end
  
  def distance_from_location(other_location)
    Geocoder::Calculations.distance_between(self.coordinates_as_string, other_location.coordinates_as_string)    
  end
  
  def time_difference_between_location(other_location)
    # returns the time difference in minutes
    Float((self.datetime - other_location.datetime) * (24 * 60)).abs
  end
end