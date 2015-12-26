define([
	'../collections/type_collection',
	'./type_row_view'
], function(
	TypeCollection,
	TypeRowView
) {
	var TypesView = Backbone.View.extend({
		template: _.template($('#types-home').html()),
		collection: new TypeCollection(),
		initialize: function() {
			this.collection.fetch({
				success: this.render.bind(this)
			});
		},
		render: function() {
			this.$el.empty().append(this.template());
			var self = this;
			this.collection.each(function(type) {
				var typeRow = new TypeRowView({
					model: type
				});
				self.$('.types-table tbody').append(typeRow.render().$el);
			});
		}
	});
	
	return TypesView;
});
