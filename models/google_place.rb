require './db/environment.rb'  # need for db settings. eventually want to auto-load this probably

require 'json'
require 'rest-client'
require './api_keys'


class Type < ActiveRecord::Base
  has_and_belongs_to_many :google_places
end  

def type_find_or_create_by_name(name)
  # Have to do this b/c the activerecord association means we cant reference the type class? wtf?
  Type.find_or_create_by(name: name)
end

class GooglePlace  < ActiveRecord::Base
  GOOGLE_PLACES_BASE_URL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
  DEFAULT_RADIUS = 10

  has_and_belongs_to_many :types
  has_and_belongs_to_many :location_coordinates
  
  def self.url_for_lat_long(lat, lng)
    location_str = [lat, lng].join(',')
    GOOGLE_PLACES_BASE_URL + "?location=#{location_str}&radius=#{DEFAULT_RADIUS}&key=#{GOOGLE_PLACES_CLIENT_KEY}"
  end

  def self.fetch_and_create_places_for_coordinates(lat, long)
    response = RestClient.get(self.url_for_lat_long(lat, long))    
    JSON.parse(response)['results'].map do |json_google_place|
      self.init_from_json(json_google_place)      
    end
  end
  
  def self.init_from_json(json)
    existing_google_place = self.find_by(google_id: json['id'])
    if existing_google_place
      return existing_google_place
    end
    
    google_place = self.create(
      google_id: json['id'],
      place_id: json['place_id'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
      name: json['name'],
    )

    json['types'].each do |type_string|
      type = type_find_or_create_by_name(type_string)
      google_place.types.push(type)
      google_place.save()
    end
    google_place
  end
end

