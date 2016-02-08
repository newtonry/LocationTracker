define([
], function(
) {
	// The endpoint returns data from all sorts of networks
	var ExternalActionDataModel = Backbone.Model.extend({
		url: function() {
			return '/api/actions/' + this.get('id') + '/external-api-data/';
		},
		
		parse: function(json_data) {
			json_data.google_places = new Backbone.Collection(json_data.google_places.results);
			json_data.yelp_businesses = new Backbone.Collection(json_data.yelp_businesses);
			return json_data;
		}
	});
	
	return ExternalActionDataModel;
});
