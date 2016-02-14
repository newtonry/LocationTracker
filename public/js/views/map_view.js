// Can take a list of LocationCoordinates

define([], function() {
	var MapView = Backbone.View.extend({
		initialize: function(options) {
			options = options || {};
			this.defaultIconUrl = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|'
			this.zoom = options.zoom || 13;

			this.map = new google.maps.Map(document.getElementById('map'), {
				center: {
					lat: this.collection.first().get('lat'),
					lng: this.collection.first().get('lng')
				},
				zoom: this.zoom
			});
		},
		
		render: function() {
			this.collection.each(function(location) {
				this.addPoint(location);
			}, this);
		},
		
		addPoint: function(location, color) {
			debugger
			
			color = color || 'FF0000';
			var mapMarker = location.addMarkerToMap(this.map);
			mapMarker.setIcon(this.defaultIconUrl + color);
			google.maps.event.addListener(mapMarker, 'click', function() {
			  // TODO look into title vs infowindow. Infowindow may not be the right way to do it.
				location.getGoogleMapsInfoView().open(this.map, mapMarker);
			});
		}
	});
	
	return MapView;
});
