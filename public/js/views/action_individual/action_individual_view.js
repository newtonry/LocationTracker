define([
	'../../models/action_model',
	'../../models/external_models/external_action_data_model',
	'./action_individual_location_coordinates_table_view',
	'./external_action_data_view',
	'../map_view',
	'../../utils'
], function(
	ActionModel,
	ExternalActionDataModel,
	ActionIndividualLocationCoorinatesTableView,
	ExternalActionDataView,
	MapView,
	Utils
) {

	var ActionIndividualView = Backbone.View.extend({
		events: {
			'click [data-action="getExternalSourceData"]': 'getExternalSourceData',
			'click [data-action="showLocationCoordinatesTable"]': 'showLocationCoordinatesTable'
		},
		
		template: _.template($('#action-individual').html()), // TODO the main template shouldn't be a table in the long run
	
		initialize: function(options) {
			this.activeView = 'locationCoordinatesTableView';
			
			this.model = new ActionModel({
				id: options.id
			});
			var self = this;
			this.model.fetch({
				success: function() {
					self.model.fetched = true;
					self.render();
				}
			});
			this.externalActionData = new ExternalActionDataModel({
				id: this.model.get('id')
			});
		},
	
		render: function() {
			this.$el.empty();
			
			if (!this.model.fetched) {
				this.$el.append(_.template($('#loading-spinner').html())());
				return this;
			}
			
			this.$el.append(this.template(
				_.extend(this.model.toJSON(), {activeView: this.activeView})
			));
			$('#map').show();  // Need to remove this. Reliant of moving the map el out of the home controller

			if (this.activeView == 'externalDataView') {
				var externalActionDataView = new ExternalActionDataView({
					model: this.externalActionData
				});
				this.$('.content-container').append(externalActionDataView.render().$el);
			} else {
				var actionIndividualLocationCoorinatesTableView = new ActionIndividualLocationCoorinatesTableView({
					collection: this.model.get('location_coordinates')
				});
				this.$('.content-container').append(actionIndividualLocationCoorinatesTableView.render().$el);
			}

			this.mapView = new MapView({collection: this.model.get('location_coordinates')});

			debugger
			this.mapView.addPoint(this.model.get('midpoint'), '00FF00');
			this.mapView.render();

			// var hexValues = Utils.redHexValues(this.model.get('location_coordinates').length);
				// http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FF0000

			return this;
		},
		
		showLocationCoordinatesTable: function(e) {
			e.preventDefault();
			this.activeView = 'locationCoordinatesTableView';
			this.render();
		},
		
		getExternalSourceData: function(e) {
			e.preventDefault();
			this.activeView = 'externalDataView';
			this.render();
			if (this.externalActionData.fetched) {
				return;
			}
			var self = this;
			this.externalActionData.fetch({
				success: function() {
					self.externalActionData.fetched = true;
					self.render();
				}
			});
		}
	});


	return ActionIndividualView;

});
