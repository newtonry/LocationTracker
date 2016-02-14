require './db/environment'  # need for db settings. eventually want to auto-load this probably

require 'yelp'
require './api_keys'
require './models/type'


Yelp.client.configure do |config|
  config.consumer_key = YELP_KEYS[:CONSUMER_KEY]
  config.consumer_secret = YELP_KEYS[:CONSUMER_SECRET]
  config.token = YELP_KEYS[:TOKEN]
  config.token_secret = YELP_KEYS[:TOKEN_SECRET]
end


def type_find_or_create_by_name(name)
  # Have to do this b/c the activerecord association means we cant reference the type class? wtf?
  Type.find_or_create_by(name: name)
end


class YelpBusiness < ActiveRecord::Base
  has_and_belongs_to_many :types
  has_and_belongs_to_many :location_coordinates, class_name: 'LocationCoordinates'
  
  RADIUS_FILTER = 100  # in meters
  SORT = 1  # Relates to yelp api sort param https://www.yelp.com/developers/documentation/v2/search_api. 1 is by distance

  def self.fetch_and_create_businesses_for_location_coordinates(location)
    businesses = self.get_businesses_for_coordinates(location)
    businesses.map do |business|
      create_business_from_yelp_response(business) if business.distance <= RADIUS_FILTER  # Yelp gives us back many distances
    end.compact
  end

  def self.get_businesses_for_coordinates(location)
    coordinates_hash = {
      latitude: location.lat,
      longitude: location.lng
    }
    
    params = {
      radius_filter: RADIUS_FILTER,
      sort: SORT
    }

    # Filtering here because Yelp returns results even outside of the distance given >_<
    Yelp.client.search_by_coordinates(coordinates_hash, params).businesses.select do |business|
      business.distance <= RADIUS_FILTER
    end
  end

  def self.create_business_from_yelp_response(business)
    # TODO might want to lookup by yelp id first

    created_business = self.create(
      address: business.location.display_address.join(','),
      name: business.name,
      url: business.url,
      yelp_id: business.id
    )

    if business.categories      
      created_business.types = business.categories.map do |type_name|
        type_find_or_create_by_name(type_name[1])
      end
    end
    created_business
  end
end
