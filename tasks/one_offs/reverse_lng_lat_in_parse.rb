require 'rest-client'
require './api_keys'
require './models/location_coordinates.rb'


PARSE_BASE_JS_URL = "https://#{PARSE_APP_ID}:javascript-key=#{PARSE_JS_KEY}@api.parse.com/1/classes/LocationCoordinates/"


# When I first wrote the android app, lat and long were backwards, so this fixes that

def reverse_long_and_lat_for_name(name)
  last_time = LocationCoordinates.first.time_visited
  json_locs = LocationCoordinates.fetch_all_json_from_parse_after_create_date(last_time)

  json_locs = json_locs.select do |json_loc|
    json_loc['username'] == name
  end

  json_locs.each do |json_loc|    
    json_loc['location'] = json_loc['location'].split(',').reverse.join(',')
    update_to_parse(json_loc)
  end
end

def update_to_parse(json_loc)
  parse_id = json_loc['objectId']
  json_loc.delete('objectId')
  RestClient.put(PARSE_BASE_JS_URL + parse_id, json_loc.to_json, {content_type: :json})  
end


reverse_long_and_lat_for_name("Xin")