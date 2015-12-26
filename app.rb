require 'json'
require 'sinatra'
# require 'sinatra/partial'
require './api_keys.rb'
require './models/google_place'
require './models/location_coordinates'
require './models/trip'
require './models/type'


# set :server, 'webrick'
set :partial_template_engine, :erb

get '/' do
  erb :index, :locals => {:google_maps_api_key => GOOGLE_MAPS_JS_API_KEY}
end

get '/api/google-places/' do
  content_type :json
  GooglePlace.includes(:types).all.to_json(include: :types, methods: :number_of_location_coordinates)
end

get '/api/trips/' do
  content_type :json
  Trip.includes(:location_coordinates).all.to_json(:include => :location_coordinates)
end

get '/api/trips/:id/' do
  content_type :json
  Trip.includes(location_coordinates: [:types]).find(params['id']).to_json(include: {
    location_coordinates: {
      include: [
        :google_places,
        :types
      ]
    }
  })
end

get '/api/types/' do
  content_type :json
  Type.all.to_json
end











