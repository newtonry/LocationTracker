define([
	'../collections/action_collection',
	'./actions_filter_view',
	'./action_row_view',
	'./map_view'
	
], function(
	ActionCollection,
	ActionsFilterView,
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
			this.$el.empty().append(this.template());

			// TODO should we not be instantiating these a lot of times?
			this.actionsFilterView = new ActionsFilterView({
				collection: this.actions
			});
			this.$('.actions-filter').append(this.actionsFilterView.render().$el);
			this.listenTo(this.actionsFilterView, 'change', this.render)

			var self = this;
			this.actions.getFilteredActions().each(function(action) {
				var actionRowView = new ActionRowView({
					model: action
				});
			
				self.listenTo(actionRowView, 'selectPointOnMap', self.setMapCenterFromAction);

				self.$('.actions-table tbody').append(actionRowView.render().$el);
			});
			
			this.mapView = new MapView({
				collection: new Backbone.Collection(this.actions.getFilteredActions().pluck('midpoint')),
				zoom: 2
			});
			this.mapView.render();
		},
		
		setMapCenterFromAction: function(action) {
			var mapMarker = action.get('midpoint').get('mapMarker');
			this.mapView.map.setCenter(
				mapMarker.getPosition()
			);
			this.mapView.map.setZoom(17);
		    action.get('midpoint').getGoogleMapsInfoView().open(this.mapView.map, mapMarker);
			
			$('body').scrollTop(0);  // TODO probably shouldn't need this in the future
		}
	});
	
	return ActionsHomeView;
});
