define([
	'../collections/user_collection'
], function(
	UserCollection
) {

	var ActionsFilterView = Backbone.View.extend({
		events: {
			'change .user-selection': 'valueChanged'
		},
		template: _.template($('#actions-filter').html()),
		initialize: function() {
			this.userCollection = new UserCollection();
			this.userCollection.fetch();
			this.listenTo(this.userCollection, 'sync', this.render)
		},
		render: function() {
			this.$el.empty().append(this.template());

			this.userCollection.each(function(user) {
				this.$('.user-selection').append('<option value="' + user.get('id') + '">' + user.get('username') + '</option>');
			}, this)
			return this;
		},
		valueChanged: function() {
			var userId = this.$('.user-selection').val() === 'all_users' ? null : parseInt(this.$('.user-selection').val());
			this.collection.filters.user_id = userId;
			this.trigger('change');
		}
	});

	return ActionsFilterView;
});
