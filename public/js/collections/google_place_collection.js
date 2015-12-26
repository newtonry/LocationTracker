define([
	'../models/google_place_model'
], function(
	GooglePlace
) {
	var GooglePlacesCollection = Backbone.Collection.extend({
		url: '/api/google-places/',
		model: GooglePlace,
		getNamesString: function() {
			return this.map(function(googlePlace) {
				return googlePlace.get('name');
			}).join(', ');
		}
	});
	
	return GooglePlacesCollection;
});
