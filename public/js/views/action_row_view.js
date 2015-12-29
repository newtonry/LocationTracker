define([], function() {

	var ActionRowView = Backbone.View.extend({
		tagName: 'tr',
		template: _.template($('#action-row').html()),
		render: function() {
			this.$el.empty().append(this.template(this.model.toJSON()));
			return this;
		}
	});

	return ActionRowView;
});
