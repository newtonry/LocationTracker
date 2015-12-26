CREATE TABLE location_coordinates(
	id INTEGER,
	parse_id TEXT,
	lat REAL,
	lng REAL,
	time_visited TEXT,
	PRIMARY KEY(id)
);

ALTER TABLE location_coordinates ADD COLUMN trip_id INTEGER;
