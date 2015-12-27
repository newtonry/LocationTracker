CREATE TABLE location_coordinates(
	id INTEGER,
	parse_id TEXT,
	lat REAL,
	lng REAL,
	time_visited TEXT,
	PRIMARY KEY(id)
);

ALTER TABLE location_coordinates ADD COLUMN trip_id INTEGER;
-- ALTER TABLE location_coordinates ADD COLUMN visit_id INTEGER;

-- ALTER TABLE location_coordinates DROP COLUMN visit_id;  DROP COLUMN is complex in sqlite
-- ALTER TABLE location_coordinates DROP COLUMN action_index;  DROP COLUMN is complex in sqlite

ALTER TABLE location_coordinates ADD COLUMN action_id INTEGER;
ALTER TABLE location_coordinates ADD COLUMN action_index INTEGER;