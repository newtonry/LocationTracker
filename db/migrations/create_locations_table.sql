CREATE TABLE location_coordinates(
	id INTEGER,
	parse_id TEXT,
	lat REAL,
	lng REAL,
	time_visited TEXT,
	PRIMARY KEY(id)
);



CREATE TABLE google_place(
	id INTEGER,
	PRIMARY KEY(id)
);





-- CREATE TABLE users(
-- 	id INTEGER,
-- 	name TEXT,
-- 	occupation TEXT,
-- 	PRIMARY KEY(id)
-- );
