require 'json'
require 'sinatra'
require './api_keys'
require './constants'
require './models/action'
require './models/google_place'
require './models/location_coordinates'
require './models/trip'
require './models/type'
require './models/user'


set :partial_template_engine, :erb

get '/' do
  erb :index, :locals => {:google_maps_api_key => GOOGLE_MAPS_JS_API_KEY}
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








