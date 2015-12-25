define([
	'./location_coordinates_model'
], function(
	LocationCoordinates
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
			json.start = json.location_coordinates.first();
			json.finish = json.location_coordinates.last()
			return json;
		}
	});
	
	return Trip;
});
