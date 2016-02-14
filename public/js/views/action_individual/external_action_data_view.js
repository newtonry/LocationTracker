define([], function() {

	var ExternalActionDataView = Backbone.View.extend({
		template: _.template($('#external-action-data-container').html()),
		initialize: function() {
			this.listenTo(this.model, 'sync', this.render);
		},
		render: function() {
			this.$el.empty();
			if (!this.model.fetched) {
				this.$el.append(_.template($('#loading-spinner').html())());				
				return this;
			}

			this.$el.append(this.template());
			var self = this;
			var foursquareInfoTemplate = _.template($('#external-foursquare-row').html());
			var googlePlaceInfoTemplate = _.template($('#external-google-row').html());
			var yelpInfoTemplate = _.template($('#external-yelp-row').html());

			this.model.get('foursquare_venues').each(function(foursquareVenue) {
				self.$('.foursquare-venue-div').append(foursquareInfoTemplate(foursquareVenue.toJSON()));
			});
			this.model.get('google_places').each(function(googlePlace) {
				self.$('.google-place-div').append(googlePlaceInfoTemplate(googlePlace.toJSON()));
			});
			this.model.get('yelp_businesses').each(function(yelpBusiness) {
				self.$('.yelp-place-div').append(yelpInfoTemplate(yelpBusiness.toJSON()));
			});
			return this;
		}
	});

	return ExternalActionDataView;
});
