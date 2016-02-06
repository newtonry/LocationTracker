define([
	'../collections/user_collection'
], function(
	UserCollection
) {

	var ActionsFilterView = Backbone.View.extend({
		events: {
			'change .user-selection': 'valueChanged',
			'change .action-type-selection': 'valueChanged'			
		},
		template: _.template($('#actions-filter').html()),
		initialize: function() {
			this.userCollection = new UserCollection();
			this.userCollection.fetch();
			this.listenTo(this.userCollection, 'sync', this.render)
		},
		render: function() {
			this.$el.empty().append(this.template({
				type_index: this.collection.filters.type_index
			}));
			
			this.userCollection.each(function(user) {
				// TODO this should prob be done in a template!!!
				this.$('.user-selection').append('<option value="' +
				user.get('id') +
				'"' +
				(this.collection.filters.user_id === user.get('id') ? ' selected' : '') +
				'>' +
				user.get('username') +
				'</option>');
			}, this)
			return this;
		},
		valueChanged: function() {
			var userId = this.$('.user-selection').val() === 'all_users' ? null : parseInt(this.$('.user-selection').val());
			this.collection.filters.user_id = userId;			
			var type_index = this.$('.action-type-selection').val() === 'all_types' ? null : parseInt(this.$('.action-type-selection').val());
			this.collection.filters.type_index = type_index;
			this.trigger('change');
		}
	});

	return ActionsFilterView;
});
