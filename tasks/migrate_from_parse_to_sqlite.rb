require 'active_record'
require 'sqlite3'
require './models/location_coordinates.rb'


def migrate_from_parse_to_sqlite
  locs = LocationCoordinates.fetch_all_from_parse
  locs.each do |loc|  
    loc.save! if !LocationCoordinates.find_by(parse_id: loc.parse_id)
  end

  p "Migration of all Parse records complete. There are now #{LocationCoordinates.count} LocationCoordinates total."
end

migrate_from_parse_to_sqlite