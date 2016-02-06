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
			json.google_places = new GooglePlaceCollection(json.google_places, {parse: true});
			json.types = new TypeCollection(json.types, {parse: true})
			return json;
		},
		
		toCoordinateString: function() {
			return [this.get('lat'), this.get('lng')].join(',');
		},
		
		toGoogleMapsLngLat: function() {
			return new google.maps.LatLng(this.get('lat'), this.get('lng'));
		},
		
		getGoogleMapsInfoView: function() {
		  return new google.maps.InfoWindow({
			  content: this.get('marker_text')
		  });		
		},
		
		addMarkerToMap: function(map) {
			this.set('mapMarker', new google.maps.Marker({
	  		    position: {
	  		    	lat: this.get('lat'),
					lng: this.get('lng')
	  		    },
	  		    map: map,
	  		    title: 'A point'
	  		  }));
			  return this.get('mapMarker');
		}
	});
	
	return LocationCoordinates;
});
