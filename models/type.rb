require './db/environment'  # need for db settings. eventually want to auto-load this probably

class Type < ActiveRecord::Base
  has_and_belongs_to_many :google_places
  has_and_belongs_to_many :yelp_businesses
  
  def frequency
    self.google_places.count
  end
end  
