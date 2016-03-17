require './db/environment.rb'  # need for db settings. eventually want to auto-load this probably

require 'rest-client'
require './api_keys'
require './models/location_coordinates'
require './models/user'


class Visit < ActiveRecord::Base

  belongs_to :user
  
  
  PARSE_BASE_JS_URL = "https://#{PARSE_APP_ID}:javascript-key=#{PARSE_JS_KEY}@api.parse.com/1/classes/#{self.name}?limit=1000"
  PARSE_LIMIT = 1000  # TODO should go in constants file

  def self.parse_url    
    return PARSE_BASE_JS_URL
  end
  
  def self.fetch_all_from_parse_after_create_date(create_date)
    json_results = self.fetch_all_json_from_parse_after_create_date(create_date)

    json_results.map do |json_visit|
      self.init_from_json(json_visit)
    end.compact
  end

  def self.fetch_all_json_from_parse_after_create_date(create_date)
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

    json_results
  end
  
  def self.init_from_json(json)
    return if json['location'] == 'coords'  # For whatever reason our coordinates aren't there a bunch of the time?
    
    departure_date = DateTime.parse(json['departureDate']['iso'])
    return if departure_date >  Date.new(3000, 1, 1)  # If the trip hasn't been finished yet, CLVisit gives us year 4001? Prob don't want to save it yet
    user = User.find_or_create_by(username: json['username'])
    
    lat, lng = json['location'].split(',')
    self.new(
      lat: Float(lat),
      lng: Float(lng),
      parse_id: json['objectId'],
    	arrival_date: DateTime.parse(json['arrivalDate']['iso']),
    	departure_date: departure_date,
    	horizontal_accuracy: Float(json['horizontalAccuracy']),
      user_id: user.id
    )
  end
  
  
  def location_coordinates
    LocationCoordinates.new(lat: self.lat, lng: self.lng)
  end
  
  def time_spent
    Float((DateTime.parse(self.departure_date) - DateTime.parse(self.arrival_date)) * (24 * 60)).abs    
  end
  
end