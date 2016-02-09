require 'json'
require 'rest-client'
require 'sinatra'
require './api_keys'
require './constants'
require './models/action'
require './models/foursquare_venue'
require './models/google_place'
require './models/location_coordinates'
require './models/trip'
require './models/type'
require './models/user'
require './models/yelp_business'


set :partial_template_engine, :erb

get '/' do
  erb :index, :locals => {
    :google_maps_api_key => GOOGLE_MAPS_JS_API_KEY,
    :yelp_keys => YELP_KEYS
  }
end

get '/api/actions/' do
  content_type :json
  # Action.where(type_index: LocationCoordinatesActionType.VISIT[:index]).to_json(
  Action.includes(:user).all.to_json({
    methods: [
      :finish_with_venues_and_types,
      :location_coordinates_count,
      :midpoint,
      :start_with_venues_and_types, 
      :time_taken,
      :type
    ],
    include: :user}
  )
end

get '/api/actions/:id/' do
  content_type :json
  Action.find(params['id']).to_json(include: [:location_coordinates, :user], methods: :type)
end

get '/api/actions/:id/external-api-data/' do
  # This endpoint is just making a bunch of external calls now and returning that data. We want to store it in the longrun I think
  content_type :json
  action = Action.find(params['id'])

  google_places_url = GooglePlace.url_for_lat_long(action.midpoint.lat, action.midpoint.lng)
  google_places_response = JSON.parse(RestClient.get(google_places_url))
  yelp_businesses_response = YelpBusiness.get_businesses_for_coordinates(action.midpoint)
  foursquare_venues_response = FoursquareVenue.fetch_for_location_coordinates(action.midpoint)
  
    
  external_api_data  = {
    google_places: google_places_response,
    yelp_businesses: yelp_businesses_response,
    foursquare_venues: foursquare_venues_response
  }
  external_api_data.to_json
end



get '/api/google-places/' do
  content_type :json
  GooglePlace.includes(:types).all.to_json(include: :types, methods: :number_of_location_coordinates)
end

get '/api/trips/' do
  content_type :json
  Trip.all.to_json(
    methods: [
      :start,
      :finish
    ]
  )
end

get '/api/trips/:id/' do
  content_type :json
  Trip.includes(:user, location_coordinates: [:types]).find(params['id']).to_json(include: [{
    location_coordinates: {
      include: [
        :google_places,
        :yelp_businesses,
        :types
      ]
    }
  }, :user])
end

get '/api/types/' do
  content_type :json
  Type.all.to_json(methods: :frequency)
end


get '/api/users/' do
  content_type :json
  User.all.to_json(methods: [
    :actions_count,
    :location_coordinates_count,
    :trips_count
  ])
end

get '/api/users/:id/' do
  content_type :json
  User.find(params['id']).to_json
end








