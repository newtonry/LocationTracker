require([
	'./views/google_places_home_view',
	'./views/trips_home_view',
	'./views/trip_individual_view',
	'./views/types_view'
], function(
	GooglePlacesHomeView,
	TripsHomeView,
	TripIndividualView,
	TypesView
) {
	$(document).ready(function() {

		var LocationTrackerRouter = Backbone.Router.extend({
		    routes: {
				"": "trips",  // Going to trips on index for now
				"google-places/": "googlePlaces",
				"trips/": "trips",
		        "trips/:id": "trip",
		        "types/": "types"
				
		    },
			googlePlaces: function() {
				var googlePlacesHomeView = new GooglePlacesHomeView({
					el: $('#main-container')
				});				
			},
			
		    trip: function(id) {
				var tripIndividualView = new TripIndividualView({
					el: $('#main-container'),
					id: id
				});
		    },
		    trips: function() {
				var tripsHomeView = new TripsHomeView({
					el: $('#main-container')
				});
		    },
			types: function() {
				var typesView = new TypesView({
					el: $('#main-container')
				});
			}
		});
	
		new LocationTrackerRouter();
	
		Backbone.history.start();
	});
});
