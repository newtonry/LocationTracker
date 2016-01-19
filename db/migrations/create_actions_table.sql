CREATE TABLE actions(
	id INTEGER,
	type_index INTEGER,
	PRIMARY KEY(id)
);

ALTER TABLE actions ADD COLUMN user_id INTEGER;