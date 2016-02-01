CREATE TABLE yelp_businesses(
	id INTEGER,
	name TEXT,
	yelp_id TEXT,
	address TEXT,
	url TEXT,
	PRIMARY KEY(id)
);

CREATE TABLE types_yelp_businesses(
	id INTEGER,
	yelp_business_id INTEGER,
	type_id INTEGER,
	PRIMARY KEY(id)
);

CREATE TABLE location_coordinates_yelp_businesses(
	id INTEGER,
	user_id INTEGER,
	yelp_business_id INTEGER,
	location_coordinates_id INTEGER,
	PRIMARY KEY(id)
);
