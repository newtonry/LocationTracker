DROP TABLE google_places;
DROP TABLE google_places_location_coordinates;
DROP TABLE google_places_types;
DROP TABLE location_coordinates;
DROP TABLE location_coordinates_yelp_businesses;
DROP TABLE trips;
DROP TABLE types;
DROP TABLE types_yelp_businesses;
DROP TABLE users;
DROP TABLE yelp_businesses;



CREATE TABLE actions(
	id INTEGER,
	user_id INTEGER,
	type_index INTEGER,
	PRIMARY KEY(id)
);

CREATE INDEX `userid_typeindex_id` ON `actions` (`user_id`, `type_index`, `id`);
CREATE INDEX `typeindex_id` ON `actions` (`type_index`, `id`);

CREATE TABLE google_places(
	id INTEGER,
	lat REAL,
	lng REAL,
	google_id TEXT,
	place_id TEXT,
	name TEXT,
	PRIMARY KEY(id)
);

CREATE INDEX `googleid_id` ON `google_places` (`google_id`, `id`);
CREATE INDEX `placeid_id` ON `google_places` (`place_id`, `id`);

CREATE TABLE google_places_types(
	id INTEGER,
	google_place_id INTEGER,
	type_id INTEGER,
	PRIMARY KEY(id)
);

CREATE INDEX `googleplaceid_id` ON `google_places_types` (`google_place_id`, `id`);
CREATE INDEX `typeid_id` ON `google_places_types` (`type_id`, `id`);

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

CREATE INDEX `locationcoordinatesid_id` ON `google_places_location_coordinates` (`location_coordinates_id`, `id`);

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

CREATE INDEX `userid_id` ON `location_coordinates` (`user_id`, `id`);
CREATE INDEX `tripid_id` ON `location_coordinates` (`trip_id`, `id`);
CREATE INDEX `actionid_id` ON `location_coordinates` (`action_id`, `id`);
CREATE INDEX `userid_tripid_id` ON `location_coordinates` (`user_id`, `trip_id`, `id`);
CREATE INDEX `userid_actionid_id` ON `location_coordinates` (`user_id`, `action_id`, `id`);

CREATE TABLE trips(
	id INTEGER,
	user_id INTEGER,
	total_time REAL,
	total_distance REAL,
	PRIMARY KEY(id)
);

CREATE INDEX `userid_id` ON `trips` (`user_id`, `id`);

CREATE TABLE users(
	id INTEGER,
	username TEXT,
	PRIMARY KEY(id)
);

CREATE INDEX `username_id` ON `users` (`username`, `id`);

CREATE TABLE yelp_businesses(
	id INTEGER,
	name TEXT,
	yelp_id TEXT,
	address TEXT,
	url TEXT,
	PRIMARY KEY(id)
);

CREATE INDEX `yelpid_id` ON `yelp_businesses` (`yelp_id`, `id`);

CREATE TABLE types_yelp_businesses(
	id INTEGER,
	yelp_business_id INTEGER,
	type_id INTEGER,
	PRIMARY KEY(id)
);

CREATE INDEX `yelpbusinessid_id` ON `types_yelp_businesses` (`yelp_business_id`, `id`);
CREATE INDEX `typeid_id` ON `types_yelp_businesses` (`type_id`, `id`);

CREATE TABLE location_coordinates_yelp_businesses(
	id INTEGER,
	user_id INTEGER,
	yelp_business_id INTEGER,
	location_coordinates_id INTEGER,
	PRIMARY KEY(id)
);

CREATE INDEX `locationcoordinatesid_id` ON `location_coordinates_yelp_businesses` (`location_coordinates_id`, `id`);

