define([
	'../collections/user_collection',
	'./user_row_view'
	
], function(
	UserCollection,
	UserRowView
) {
	var UsersView = Backbone.View.extend({
		template: _.template($('#users-home').html()),
		collection: new UserCollection(),
		initialize: function() {
			this.collection.fetch({
				success: this.render.bind(this)
			});
		},
		render: function() {
			this.$el.empty().append(this.template());
			this.collection.each(function(user) {
				var userRow = new UserRowView({
					model: user
				});
				this.$('.users-table tbody').append(userRow.render().$el);
			}, this);

			return this;
		}
	});
	
	return UsersView;
});
