require 'sqlite3'

require 'pry'

db = SQLite3::Database.new( "db/location-tracker.db" )

binding.pry