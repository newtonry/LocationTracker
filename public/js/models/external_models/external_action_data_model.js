define([
	'../../collections/external_collections/foursquare_venue_collection',
	'../../collections/external_collections/google_place_collection',
	'../../collections/external_collections/yelp_business_collection'	
], function(
	FoursquareVenueCollection,
	GooglePlaceCollection,
	YelpBusinessCollection
) {
	// The endpoint returns data from all sorts of networks
	var ExternalActionDataModel = Backbone.Model.extend({
		url: function() {
			return '/api/actions/' + this.get('id') + '/external-api-data/';
		},
		
		parse: function(json_data) {
			json_data.foursquare_venues = new FoursquareVenueCollection(json_data.foursquare_venues, {parse: true});
			json_data.google_places = new GooglePlaceCollection(json_data.google_places.results, {parse: true});
			json_data.yelp_businesses = new YelpBusinessCollection(json_data.yelp_businesses, {parse: true});
			return json_data;
		}
	});
	
	return ExternalActionDataModel;
});
