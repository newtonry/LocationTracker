define([
	'../models/location_coordinates_model'
], function(
	LocationCoordinatesModel
) {
	var LocationCoordinatesCollection = Backbone.Collection.extend({
		model: LocationCoordinatesModel
	});
	
	return LocationCoordinatesCollection;
});
