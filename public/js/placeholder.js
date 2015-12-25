define([
	'./collections/trip_collection',
	'./collections/google_place_collection',
	'./models/location_coordinates_model',
	'./models/trip_model'
], function(
	TripCollection,
	GooglePlaceCollection,
	LocationCoordinates,
	Trip
) {
	return function() {
		var TripListItemView = Backbone.View.extend({
			events: {
				'click [data-action="navigateToIndividualTrip"]': 'navigateToIndividualTrip'
			},
			tagName: 'tr',
			template: _.template($("#trips-home-table-row").html()),
			navigateToIndividualTrip: function() {
				var individualTripPath = 'trips/' + this.model.get('id');
				Backbone.history.navigate(individualTripPath, {trigger:true});
				$('html,body').scrollTop(0);  // Should I really need this?
			},
		
			render: function() {
				this.$el.empty();
				this.$el.append(
					this.template({
						id: this.model.get('id'),
						startString: this.model.get('start').toCoordinateString(),
						finishString: this.model.get('finish').toCoordinateString(),
						totalTime: this.model.get('total_time')
					})
				);
			
				return this;
			}
		});
	
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
	
		var TripsHomeView = Backbone.View.extend({
			template: _.template($("#trips-home").html()),
		
			initialize: function() {
				this.trips = new TripCollection();
				this.trips.fetch({
					success: this.render.bind(this),		
				});
			},
		
			render: function() {
				this.$el.empty().append(
					this.template()
				);
	
				var self = this;
				this.trips.each(function(trip) {
					var tripListItemView = new TripListItemView({
						model: trip
					});

					self.$('.trips-table tbody').append(tripListItemView.render().$el);
				});
			
				$('#map').hide();  // Need to remove this since I'm not using map here anymore. Should put that el in the individual view
			}
		});



		var TripIndividualView = Backbone.View.extend({
			template: _.template($('#trip-location-coordinates-table').html()), // TODO the main template shouldn't be a table in the long run
		
			initialize: function(options) {
				this.model = new Trip({
					id: options.id
				});
			
				this.model.fetch({
					success: this.render.bind(this)
				});
			
			},
		
			render: function() {
				this.$el.empty();
				this.$el.append(this.template());
				$('#map').show();  // Need to remove this. Reliant of moving the map el out of the home controller
			
				var self = this;

				this.model.get('location_coordinates').each(function(location) {
					var locationCoordinatesRow = new LocationCoordinatesRow({
						model: location
					});
				
					this.$('.location-coordinates-table tbody').append(locationCoordinatesRow.render().$el);
				});

				this.mapView = new TripMapView({
					model: this.model
				});
				this.mapView.render();	
			


				return this;
			}
		});
	
		var LocationCoordinatesRow = Backbone.View.extend({
			tagName: 'tr',
			template: _.template($('#trip-location-coordinates-row').html()),
			render: function() {
				this.$el.empty().append(this.template(this.model.toJSON()));
				return this;
			}
		});

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
















