define([
	'../../collections/visit_collection',
	'./visit_row_view',
	'../map_view'
	
], function(
	VisitCollection,
	VisitRowView,
	MapView
) {
	var VisitsView = Backbone.View.extend({
		template: _.template($('#visits-home').html()),
		collection: new VisitCollection(),
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
			this.collection.each(function(visit) {
				var visitRowView = new VisitRowView({
					model: visit
				});
				
				this.listenTo(visitRowView, 'selectPointOnMap', this.setMapCenterFromAction);
				this.$('.visits-table tbody').append(visitRowView.render().$el);
			}, this);

			this.renderMap();

			return this;
		},
		renderMap: function() {
			this.mapView = new MapView({
				collection: new Backbone.Collection(this.collection.pluck('location_coordinates')),
				zoom: 2
			});
			this.mapView.render();
		},
		setMapCenterFromAction: function(visit) {
			var mapMarker = visit.get('location_coordinates').get('mapMarker');
			this.mapView.map.setCenter(
				mapMarker.getPosition()
			);
			this.mapView.map.setZoom(17);
		    visit.get('location_coordinates').getGoogleMapsInfoView().open(this.mapView.map, mapMarker);
			
			$('body').scrollTop(0);  // TODO probably shouldn't need this in the future
		}
	});
	
	return VisitsView;
});
