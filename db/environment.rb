require 'active_record'


# tells AR what db file to use
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/location-tracker.db',
  :pool => 20,
)

