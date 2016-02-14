// Can take a list of LocationCoordinates

define([], function() {
	var MapView = Backbone.View.extend({
		initialize: function(options) {
			options = options || {};
			this.defaultIconUrl = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|'
			this.zoom = options.zoom || 13;
			this.colorsArray = options.colorsArray || [];  // This allows us to give an array of colors that will be popped in order of map markers

			this.map = new google.maps.Map(document.getElementById('map'), {
				center: {
					lat: this.collection.first().get('lat'),
					lng: this.collection.first().get('lng')
				},
				zoom: this.zoom
			});
		},
		
		render: function() {
			var colorsArray = this.colorsArray.slice()
			this.collection.each(function(location) {
				var color = colorsArray.length > 0 ? colorsArray.shift() : null
				this.addPoint(location, color);
			}, this);
		},
		
		addPoint: function(location, color) {
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
