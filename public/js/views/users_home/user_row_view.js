define([], function() {

	var UserRowView = Backbone.View.extend({
		tagName: 'tr',
		template: _.template($('#user-row').html()),
		render: function() {
			this.$el.empty().append(this.template(this.model.toJSON()));
			return this;
		}
	});

	return UserRowView;
});
