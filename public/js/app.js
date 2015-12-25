require([
	'./views/trips_home_view',
	'./views/trip_individual_view',
	'./views/types_view'
], function(
	TripsHomeView,
	TripIndividualView,
	TypesView
) {
	$(document).ready(function() {

		var LocationTrackerRouter = Backbone.Router.extend({
		    routes: {
				"": "trips",  // Going to trips on index for now
				"trips/": "trips",
		        "trips/:id": "trip",
		        "types/": "types"
				
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
