define([
	'../collections/action_collection',
	'./action_row_view',
	'./map_view'
	
], function(
	ActionCollection,
	ActionRowView,
	MapView
) {

	var ActionsHomeView = Backbone.View.extend({
		template: _.template($("#actions-home").html()),
	
		initialize: function() {
			this.actions = new ActionCollection();
			this.actions.fetch({
				success: this.render.bind(this),		
			});
		},
	
		render: function() {
			this.$el.empty().append(
				this.template()
			);

			var self = this;
			this.actions.each(function(action) {
				var actionRowView = new ActionRowView({
					model: action
				});

				self.$('.actions-table tbody').append(actionRowView.render().$el);
			});
			
			this.mapView = new MapView({
				collection: new Backbone.Collection(this.actions.pluck('midpoint')),
				zoom: 2
			});
			this.mapView.render();	
		}
	});
	
	return ActionsHomeView;
});
