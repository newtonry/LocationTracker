require 'geocoder'
require 'rest-client'
require './api_keys'
require './models/google_place.rb'


class LocationCoordinates
  PARSE_BASE_JS_URL = "https://#{PARSE_APP_ID}:javascript-key=#{PARSE_JS_KEY}@api.parse.com/1/classes/#{self.name}"
  
  def self.url    
    return PARSE_BASE_JS_URL
  end

  def self.fetch_all
    response = RestClient.get(self.url)

    JSON.parse(response)['results'].map do |json_location_coordinate|
      self.init_from_json(json_location_coordinate)
    end
  end
  
  def self.init_from_json(json)
    long, lat = json['location'].split(',')
    self.new(json['createdAt'], long, lat)
  end

  def initialize(create_date, lat, long)
    @create_date = create_date
    @lat = lat
    @long = long    
  end
  
  def datetime
    DateTime.parse(@create_date)
  end
  
  def coordinates_as_string
    return "#{@lat},#{@long}"    
  end
  
  def get_places
    GooglePlace.fetch_places_for_coordinates(@lat, @long)
  end
  
  def distance_from_location(other_location)
    Geocoder::Calculations.distance_between(self.coordinates_as_string, other_location.coordinates_as_string)    
  end
  
  def time_difference_between_location(other_location)
    # returns the time difference in minutes
    ((self.datetime - other_location.datetime) * (24 * 60)).to_i
  end  
end