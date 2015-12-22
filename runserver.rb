
require 'json'
require 'sinatra'
require 'sinatra/partial'
require './api_keys.rb'
require './models/location_coordinates'
require './models/trip'


require 'pry'

set :server, 'webrick'
set :partial_template_engine, :erb


get '/' do
  
  locs = LocationCoordinates.fetch_all_from_parse
  
  # binding.pry
  
  erb :index, :locals => {:google_maps_api_key => GOOGLE_MAPS_JS_API_KEY}
end


get '/api/trips/' do
  content_type :json

  locs = LocationCoordinates.fetch_all_from_parse
  trips = Trip.generate_from_locations(locs)

  trips.map do |trip|
    trip.to_hash
  end.to_json
end
