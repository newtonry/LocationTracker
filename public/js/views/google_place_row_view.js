define([], function() {

	var GooglePlaceRowView = Backbone.View.extend({
		tagName: 'tr',
		template: _.template($('#google-place-row').html()),
		render: function() {
			this.$el.empty().append(this.template(this.model.toJSON()));
			return this;
		}
	});

	return GooglePlaceRowView;
});
