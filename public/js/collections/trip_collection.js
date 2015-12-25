define([
	'../models/trip_model',
], function(
	Trip
) {
	var TripCollection = Backbone.Collection.extend({
		model: Trip,
		url: '/api/trips/'
	});
	
	return TripCollection;
});
