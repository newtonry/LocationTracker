define([
	'../collections/trip_collection',
	'./trip_list_item_view'
	
], function(
	TripCollection,
	TripListItemView
) {

	var TripsHomeView = Backbone.View.extend({
		template: _.template($("#trips-home").html()),
	
		initialize: function() {
			this.trips = new TripCollection();
			this.trips.fetch({
				success: this.render.bind(this),		
			});
		},
	
		render: function() {
			this.$el.empty().append(
				this.template()
			);

			var self = this;
			this.trips.each(function(trip) {
				var tripListItemView = new TripListItemView({
					model: trip
				});

				self.$('.trips-table tbody').append(tripListItemView.render().$el);
			});
		
			$('#map').hide();  // Need to remove this since I'm not using map here anymore. Should put that el in the individual view
		}
	});
	
	return TripsHomeView;
});
