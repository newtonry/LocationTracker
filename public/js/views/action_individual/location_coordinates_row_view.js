define([], function() {

	var LocationCoordinatesRowView = Backbone.View.extend({
		tagName: 'tr',
		template: _.template($('#action-location-coordinates-row').html()),
		render: function() {
			this.$el.empty().append(this.template(this.model.toJSON()));
			return this;
		}
	});

	return LocationCoordinatesRowView
});
