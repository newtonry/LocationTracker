define([
	'./views/trips_home_view',
	'./views/trip_individual_view'
], function(
	TripsHomeView,
	TripIndividualView
	
) {
	return function() {


		var LocationTrackerRouter = Backbone.Router.extend({
		    routes: {
		        "trips/:id": "trip",
		        "": "index"
		    },
		    index: function() {
				var tripsHomeView = new TripsHomeView({
					el: $('#main-container')
				});
		    },
		    trip: function(id) {
				var tripIndividualView = new TripIndividualView({
					el: $('#main-container'),
					id: id
				});
		    },
		});
	
		router = new LocationTrackerRouter();
	
		Backbone.history.start();

	};	
	
	
});
















