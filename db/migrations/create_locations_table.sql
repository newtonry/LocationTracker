CREATE TABLE location_coordinates(
	id INTEGER,
	user_id INTEGER,
	parse_id TEXT,
	lat REAL,
	lng REAL,
	time_visited TEXT,
	action_id INTEGER,
	trip_id INTEGER,
	PRIMARY KEY(id)
);

-- ALTER TABLE location_coordinates ADD COLUMN trip_id INTEGER;


-- ALTER TABLE location_coordinates DROP COLUMN action_index;  DROP COLUMN is complex in sqlite

-- ALTER TABLE location_coordinates ADD COLUMN action_id INTEGER;
-- ALTER TABLE location_coordinates ADD COLUMN action_index INTEGER;
-- ALTER TABLE location_coordinates ADD COLUMN user_id INTEGER;