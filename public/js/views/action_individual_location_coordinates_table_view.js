define([
	'./location_coordinates_row_view'
], function(
	LocationCoordinatesRowView
) {

	var ActionIndividualLocationCoorinatesTableView = Backbone.View.extend({
		template: _.template($('#action-location-coordinates-table').html()),
		initialize: function() {
			this.listenTo(this.collection, 'sync', this.render)
		},
		render: function() {
			this.$el.empty().append(this.template());
			this.collection.each(function(location) {
				var locationCoordinatesRow = new LocationCoordinatesRowView({
					model: location
				});
				this.$('.location-coordinates-table tbody').append(locationCoordinatesRow.render().$el);
			}, this);
			return this;
		}
	});

	return ActionIndividualLocationCoorinatesTableView;
});
