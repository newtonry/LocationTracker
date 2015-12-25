define([
	'../collections/type_collection',
	'../collections/google_place_collection'
], function(
	TypeCollection,
	GooglePlaceCollection
) {
	var LocationCoordinates = Backbone.Model.extend({
		parse: function(json) {
			json.time_visited = new Date(json['time_visited']);
		
			json.google_places = new GooglePlaceCollection(json.google_places, {parse: true})
			json.types = new TypeCollection(json.types, {parse: true})
			return json;
		},
		toCoordinateString: function() {
			return [this.get('lat'), this.get('lng')].join(',');
		},
		toGoogleMarker: function() {}
	});
	
	return LocationCoordinates;
});
