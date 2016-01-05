require './db/environment.rb'  # need for db settings. eventually want to auto-load this probably

require 'geocoder'
require 'rest-client'
require './api_keys'
require './utils'
require './models/google_place'


class LocationCoordinates < ActiveRecord::Base

  belongs_to :trip
  belongs_to :action
  # belongs_to :visit
  has_and_belongs_to_many :google_places
  has_many :types, through: :google_places
  
  
  PARSE_BASE_JS_URL = "https://#{PARSE_APP_ID}:javascript-key=#{PARSE_JS_KEY}@api.parse.com/1/classes/#{self.name}?limit=1000"
  PARSE_LIMIT = 1000  # TODO should go in constants file

  def self.parse_url    
    return PARSE_BASE_JS_URL
  end

  def self.fetch_all_from_parse
    # Does it in increments of 1000, but parse has a limit of skipping 10000
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

  def self.fetch_all_from_parse_after_create_date(create_date)
    # This is a totally janky method. Could easily be improved!
    json_results = []

    url = PARSE_BASE_JS_URL + URI.encode('&order=createdAt&where={"createdAt":{"$gt":{"__type":"Date","iso":"' + create_date.to_time.iso8601 + '"}}}')
    p "Starting with #{create_date.to_time.iso8601}"

    while true      
      response = RestClient.get(url)
      new_json_results = JSON.parse(response)['results']
      json_results += JSON.parse(response)['results']
      
      url = PARSE_BASE_JS_URL + URI.encode('&order=createdAt&where={"createdAt":{"$gt":{"__type":"Date","iso":"' + json_results.last['createdAt'] + '"}}}')
      p new_json_results.count
      p "Now onto results after #{json_results.last['createdAt']}"
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
  
  # TODO should just use a property or something here
  # These are just used to decipher if these are part of a trip or something. Maybe should use a different data type like linked list
  def set_next_location_coordinates(location_coordinates)
    @next_location_coordinates = location_coordinates
  end
  def get_next_location_coordinates
    @next_location_coordinates
  end
  
  # def action_type
  #   # TODO need to figure out how to do enums with active record. Naming the field action_index for now.
  #   this.action.
  #   # LocationCoordinatesActionType.from_index(self.action_index)
  # end
  
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
  
  def is_the_same_location(other_location)
    # Should we assume that it's the same location if it's within the same 100 meters?
    self.distance_from(other_location) < 100
  end
  
  
  def distance_from(other_location)
    distance_between_locations([self.lat, self.lng], [other_location.lat, other_location.lng])
    
    # Not using Geocoder for now, as it blows up Google API limits
    # Geocoder::Calculations.distance_between(self.coordinates_as_string, other_location.coordinates_as_string)
  end
  
  def time_between(other_location)
    # returns the time difference in minutes
    Float((self.datetime - other_location.datetime) * (24 * 60)).abs
  end
end