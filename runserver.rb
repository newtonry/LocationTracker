

require 'sinatra'
require './api_keys.rb'
require './models/location_coordinates'
require './models/trip'


require 'pry'

set :server, 'webrick'

get '/' do
  
  locs = LocationCoordinates.fetch_all
  
  # binding.pry
  
  erb :index, :locals => {:google_maps_api_key => GOOGLE_MAPS_JS_API_KEY}
  
  
  
  # File.read(File.join('public', 'index.html'))
end


get '/api/trips/' do
  
  locs = LocationCoordinates.fetch_all
  trips = Trip.generate_from_locations(locs)
  
  trips.map do |trip|
    trip.to_json
  end
end
