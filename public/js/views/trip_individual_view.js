define([
	'../models/trip_model',
	'./location_coordinates_row_view',
	'./trip_map_view'

	
], function(
	TripModel,
	LocationCoordinatesRowView,
	TripMapView
) {


	var TripIndividualView = Backbone.View.extend({
		template: _.template($('#trip-individual').html()), // TODO the main template shouldn't be a table in the long run
	
		initialize: function(options) {
			this.model = new TripModel({
				id: options.id
			});
		
			this.model.fetch({
				success: this.render.bind(this)
			});
		
		},
	
		render: function() {
			this.$el.empty();
			this.$el.append(this.template(this.model.toJSON()));
			$('#map').show();  // Need to remove this. Reliant of moving the map el out of the home controller
		
			var self = this;

			this.model.get('location_coordinates').each(function(location) {
				var locationCoordinatesRow = new LocationCoordinatesRowView({
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


	return TripIndividualView;

});
