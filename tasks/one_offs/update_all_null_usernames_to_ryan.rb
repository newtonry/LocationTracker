require 'rest-client'
require './api_keys'
require './models/location_coordinates.rb'


PARSE_BASE_JS_URL = "https://#{PARSE_APP_ID}:javascript-key=#{PARSE_JS_KEY}@api.parse.com/1/classes/LocationCoordinates/"


def convert_all_null_location_coordinates_to_username(name)
  current_rate_limit_count = 0
  last_time = LocationCoordinates.first.time_visited
  json_locs = LocationCoordinates.fetch_all_json_from_parse_after_create_date(last_time)


  json_locs.each do |json_loc|    
    json_loc, needs_update = add_missing_data_to_json_loc(json_loc, name)
    if needs_update
      puts "Updating location coordinates from  #{json_loc['createdAt']}"
      update_to_parse(json_loc)
      current_rate_limit_count +=1
      
      if current_rate_limit_count >= 1500
        # Rate limiting prevention
        sleep(60)
        puts "Sleeping..."
        current_rate_limit_count = 0
      end
    end
  end
end

def update_to_parse(json_loc)
  parse_id = json_loc['objectId']
  json_loc.delete('objectId')
  RestClient.put(PARSE_BASE_JS_URL + parse_id, json_loc.to_json, {content_type: :json})  
end

def add_missing_data_to_json_loc(json_loc, name)
  needs_update = false

  if !json_loc['username']
    json_loc['username'] = name
    needs_update = true
  end

  if !json_loc['timeVisited']
    json_loc['timeVisited'] = {
      "__type"=>"Date",
      "iso"=>json_loc['createdAt']      
    }
    needs_update = true
  end    
  return json_loc, needs_update
end


convert_all_null_location_coordinates_to_username("Ryan-iOS")