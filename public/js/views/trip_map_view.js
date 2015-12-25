define([], function(LocationCoordinates) {
	var TripMapView = Backbone.View.extend({
		render: function() {
			var map = new google.maps.Map(document.getElementById('map'), {
				center: {
					lat: this.model.get('start').get('lat'),
					lng: this.model.get('start').get('lng')
				},
				zoom: 13
		  });
	  
		  this.model.get('location_coordinates').each(function(location) {

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
	
	return TripMapView;
});
