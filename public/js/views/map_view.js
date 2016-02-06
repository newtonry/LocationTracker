// Can take a list of LocationCoordinates

define([], function() {
	var MapView = Backbone.View.extend({
		initialize: function(options) {
			options = options || {};
			this.zoom = options.zoom || 13;
		},
		
		render: function() {
			this.map = new google.maps.Map(document.getElementById('map'), {
				center: {
					lat: this.collection.first().get('lat'),
					lng: this.collection.first().get('lng')
				},
				zoom: this.zoom
			});

			this.collection.each(function(location) {
			  var mapMarker = location.addMarkerToMap(this.map);
			  // TODO look into title vs infowindow. Infowindow may not be the right way to do it.
			  google.maps.event.addListener(mapMarker, 'click', function() {
			    location.getGoogleMapsInfoView().open(this.map, mapMarker);
			  });			 
			}, this);
		}
	});
	
	return MapView;
});
