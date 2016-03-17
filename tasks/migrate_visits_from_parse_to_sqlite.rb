require 'active_record'
require 'sqlite3'
require './models/visit.rb'


def migrate_from_parse_to_sqlite!
  visits = Visit.fetch_all_from_parse
  visits.each do |visit|  
    visit.save! if !Visit.find_by(parse_id: visit.parse_id)
  end

  p "Migration of all Parse records complete. There are now #{Visit.count} Visits total."
end

def migrate_all_new_from_parse(after_date=nil)
  # Non-destructive. Gets the last parse id and looks after that create date (or given date)

  p "To begin with there were #{Visit.count} Visits total."

  after_date = after_date or Visit.first.time_visited
  
  visits = Visit.fetch_all_from_parse_after_create_date(after_date)
  
  visits.each do |visit|  
    visit.save! if !Visit.find_by(parse_id: visit.parse_id)
  end

  p "Migration of all Parse records complete. There are now #{Visit.count} Visit total."
end

jan_11_2016 = Date.new(2016, 1, 11) # this is the date when I changed the increment to go at 5 mins

migrate_all_new_from_parse(jan_11_2016) 