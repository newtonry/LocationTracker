require([
	'./views/action_individual/action_individual_view',	
	'./views/actions_home/actions_home_view',
	'./views/google_places_home_view',
	// './views/trips_home_view',
	// './views/trip_individual_view',
	'./views/types_home/types_view',
	'./views/users_home/users_view'	
], function(
	ActionIndividualView,
	ActionsHomeView,
	GooglePlacesHomeView,
	// TripsHomeView,
	// TripIndividualView,
	TypesView,
	UsersView
) {
	$(document).ready(function() {

		var LocationTrackerRouter = Backbone.Router.extend({
		    routes: {
				"": "actions",  // Going to trips on index for now
				"actions/": "actions",
		        "actions/:id": "action",
				"google-places/": "googlePlaces",
				// "trips/": "trips",
		        "trips/:id": "trip",
		        "types/": "types",
				"users/": "users"
		    },
		    action: function(id) {
				var actionIndividualView = new ActionIndividualView({
					el: $('#main-container'),
					id: id
				});
		    },
			actions: function() {
				new ActionsHomeView({
					el: $('#main-container')
				});
			},
			googlePlaces: function() {
				var googlePlacesHomeView = new GooglePlacesHomeView({
					el: $('#main-container')
				});				
			},
				// 		    trip: function(id) {
				// var tripIndividualView = new TripIndividualView({
				// 	el: $('#main-container'),
				// 	id: id
				// });
				// 		    },
				// 		    trips: function() {
				// var tripsHomeView = new TripsHomeView({
				// 	el: $('#main-container')
				// });
				// 		    },
			types: function() {
				var typesView = new TypesView({
					el: $('#main-container')
				});
			},
			users: function() {
				var usersView = new UsersView({
					el: $('#main-container')
				});
			}
		});
	
		new LocationTrackerRouter();
	
		Backbone.history.start();
	});
});
