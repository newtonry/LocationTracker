require './db/environment'  # need for db settings. eventually want to auto-load this probably

class Type < ActiveRecord::Base
  has_and_belongs_to_many :google_places
end  
