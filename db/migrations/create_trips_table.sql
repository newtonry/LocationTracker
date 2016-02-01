CREATE TABLE trips(
	id INTEGER,
	user_id INTEGER,
	total_time REAL,
	total_distance REAL,
	PRIMARY KEY(id)
);

-- ALTER TABLE trips ADD COLUMN user_id INTEGER;