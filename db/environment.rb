require 'active_record'
require 'sqlite3'

DB_TYPE = 'sqlite3'
DEV_DB_LOCATION = 'db/location-tracker.db'
TEST_DB_FILE_LOCATION = 'db/testdb.db'
POOL = 20


# TODO this is totally wrong, there must be a better way to do this...
if ENV['RACK_ENV'] == 'test'
  ActiveRecord::Base.establish_connection(
    :adapter => DB_TYPE,
    :database => TEST_DB_FILE_LOCATION,
    :pool => POOL
  )  
  require './tasks/one_offs/wipe_all_the_tables'
  wipe_all_the_tables!
else
  # tells AR what db file to use
  ActiveRecord::Base.establish_connection(
    :adapter => DB_TYPE,
    :database => DEV_DB_LOCATION,
    :pool => POOL
  )
end



