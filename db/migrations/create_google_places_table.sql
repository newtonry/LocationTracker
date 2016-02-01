CREATE TABLE google_places(
	id INTEGER,
	lat REAL,
	lng REAL,
	google_id TEXT,
	place_id TEXT,
	name TEXT,
	PRIMARY KEY(id)
);

CREATE TABLE google_places_types(
	id INTEGER,
	google_place_id INTEGER,
	type_id INTEGER,
	PRIMARY KEY(id)
);

CREATE TABLE types(
	id INTEGER,
	name TEXT,
	PRIMARY KEY(id)
);

CREATE TABLE google_places_location_coordinates(
	id INTEGER,
	user_id INTEGER,
	google_place_id INTEGER,
	location_coordinates_id INTEGER,
	PRIMARY KEY(id)
);
