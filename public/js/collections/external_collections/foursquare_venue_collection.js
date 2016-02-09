define([
], function(
) {
	var FoursquareVenueCollection = Backbone.Collection.extend({
		parse: function(json_data) {
			this.meta = json_data.meta;
			return json_data.response.venues;
		}
	});

	return FoursquareVenueCollection;
});
