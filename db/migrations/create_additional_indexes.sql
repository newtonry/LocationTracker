CREATE INDEX `googleplace_locationcoordinates` ON `google_places_location_coordinates` (`google_place_id`, `location_coordinates_id`);
CREATE INDEX `locationcoordinates_googleplace` ON `google_places_location_coordinates` (`location_coordinates_id`, `google_place_id`);

CREATE INDEX `googleplace_type` ON `google_places_types` (`google_place_id`, `type_id`);
CREATE INDEX `type_googleplace` ON `google_places_types` (`type_id`, `google_place_id`);
