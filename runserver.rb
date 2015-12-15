
require 'sinatra'
require './api_keys.rb'



get '/' do
  

  
  
  
  erb :index, :locals => {:google_maps_api_key => GOOGLE_MAPS_JS_API_KEY}
  
  
  
  # File.read(File.join('public', 'index.html'))
end