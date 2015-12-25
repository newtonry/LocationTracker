define([], function() {

	var TypeRowView = Backbone.View.extend({
		tagName: 'tr',
		template: _.template($('#type-row').html()),
		render: function() {
			this.$el.empty().append(this.template(this.model.toJSON()));
			return this;
		}
	});

	return TypeRowView;
});
