define([
	'../collections/google_place_collection',
	'./google_place_row_view'
], function(
	GooglePlaceCollection,
	GooglePlaceRowView
) {
	var GooglePlacesHomeView = Backbone.View.extend({
		template: _.template($('#google-places-home').html()),
		collection: new GooglePlaceCollection(),		
		initialize: function() {
			this.collection.fetch({
				success: this.render.bind(this)
			});
		},
		render: function() {
			this.$el.empty().append(this.template());
			var self = this;
			this.collection.each(function(googlePlace) {
				var googlePlaceRowView = new GooglePlaceRowView({
					model: googlePlace
				});
				self.$('.google-places-table tbody').append(googlePlaceRowView.render().$el);
			});
		}
	});
	
	return GooglePlacesHomeView;
});
