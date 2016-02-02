define([
	'./location_coordinates_model',
	'./user_model'
	
], function(
	LocationCoordinates,
	UserModel
) {
	var Trip = Backbone.Model.extend({
		url: function() {
			return '/api/trips/' + this.get('id') + '/';
		},

		parse: function(json) {
			var location_coordinates = _.map(json.location_coordinates, function(location_json) {
				return new LocationCoordinates(location_json, {parse: true});
			});	
			json.location_coordinates = new Backbone.Collection(location_coordinates);			
			json.start = new LocationCoordinates(json.start);
			json.finish = new LocationCoordinates(json.finish);
			json.user = new UserModel(json.user)			
			return json;
		}
	});
	
	return Trip;
});
