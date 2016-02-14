define([
	'../../collections/user_collection',
	'./user_row_view'
	
], function(
	UserCollection,
	UserRowView
) {
	var UsersView = Backbone.View.extend({
		template: _.template($('#users-home').html()),
		collection: new UserCollection(),
		initialize: function() {
			var self = this;
			this.collection.fetch({
				success: function() {
					self.collection.fetched = true;
					self.render();
				}
			});
		},
		render: function() {
			this.$el.empty();
			if (!this.collection.fetched) {
				this.$el.append(_.template($('#loading-spinner').html())());				
				return this;				
			}
			
			this.$el.append(this.template());
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
