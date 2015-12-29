// Can take a list of LocationCoordinates

define([], function() {
	var MapView = Backbone.View.extend({
		initialize: function(options) {
			options = options || {};
			this.zoom = options.zoom || 13;
		},
		
		render: function() {
			var map = new google.maps.Map(document.getElementById('map'), {
				center: {
					lat: this.collection.first().get('lat'),
					lng: this.collection.first().get('lng')
				},
				zoom: this.zoom
		  });
	  
		  this.collection.each(function(location) {
			  // TODO look into title vs infowindow. Infowindow may not be the right way to do it.
		      var infowindow = new google.maps.InfoWindow({
				  content: location.get('google_places').getNamesString() + "<br>" + location.get('types').getNamesString()
		      });			 

			  var marker = new google.maps.Marker({
	  		    position: {
	  		    	lat: location.get('lat'),
					lng: location.get('lng')
	  		    },
	  		    map: map,
	  		    title: 'A point'
	  		  });
		  
		      google.maps.event.addListener(marker, 'click', function() {
		        infowindow.open(map,marker);
		      });			 
		  
		  });
		}
	});
	
	return MapView;
});
