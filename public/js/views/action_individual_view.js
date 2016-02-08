define([
	'../models/action_model',
	'../models/external_models/external_action_data_model',
	'./location_coordinates_row_view',
	'./map_view',
	'../utils'
], function(
	ActionModel,
	ExternalActionDataModel,
	LocationCoordinatesRowView,
	MapView,
	Utils
) {

	var ActionIndividualView = Backbone.View.extend({
		events: {
			'click [data-action="getExternalSourceData"]': 'getExternalSourceData'
		},
		
		template: _.template($('#action-individual').html()), // TODO the main template shouldn't be a table in the long run
	
		initialize: function(options) {
			this.model = new ActionModel({
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

			// var hexValues = Utils.redHexValues(this.model.get('location_coordinates').length);

			this.model.get('location_coordinates').each(function(location) {
				var locationCoordinatesRow = new LocationCoordinatesRowView({
					model: location
				});

// http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FF0000

			
				this.$('.location-coordinates-table tbody').append(locationCoordinatesRow.render().$el);
			});

			this.mapView = new MapView({
				collection: this.model.get('location_coordinates')
			});
			this.mapView.render();	

			return this;
		},
		
		getExternalSourceData: function() {
			var x  = new ExternalActionDataModel({
				id: this.model.get('id')
			});
			x.fetch();
		}
	});


	return ActionIndividualView;

});
