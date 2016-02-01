require 'active_record'
require 'sqlite3'
require './models/location_coordinates.rb'


def migrate_from_parse_to_sqlite!
  locs = LocationCoordinates.fetch_all_from_parse
  locs.each do |loc|  
    loc.save! if !LocationCoordinates.find_by(parse_id: loc.parse_id)
  end

  p "Migration of all Parse records complete. There are now #{LocationCoordinates.count} LocationCoordinates total."
end

def migrate_all_new_from_parse(after_date=nil)
  # Non-destructive. Gets the last parse id and looks after that create date (or given date)

  p "To begin with there were #{LocationCoordinates.count} LocationCoordinates total."

  after_date = after_date or LocationCoordinates.first.time_visited
  
  locs = LocationCoordinates.fetch_all_from_parse_after_create_date(after_date)
  locs.each do |loc|  
    loc.save! if !LocationCoordinates.find_by(parse_id: loc.parse_id)
  end

  p "Migration of all Parse records complete. There are now #{LocationCoordinates.count} LocationCoordinates total."
end

jan_11_2016 = Date.new(2016, 1, 11) # this is the date when I changed the increment to go at 5 mins

migrate_all_new_from_parse(jan_11_2016)