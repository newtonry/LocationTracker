define([
	'./location_coordinates_model',
	'./user_model'
], function(
	LocationCoordinates,
	UserModel
) {
	var VisitModel = Backbone.Model.extend({
		parse: function(json) {
			json.location_coordinates = new LocationCoordinates(json.location_coordinates);
			json.user = new UserModel(json.user);
			json.location_coordinates.set('marker_text', json.user.get('username') + ' on Visit ' + json.id);
			// json.midpoint.set('marker_text', json.user.get('username') + ' on Visit ' + json.id);
			json.arrival_date = new Date(json.arrival_date);
			json.departure_date = new Date(json.departure_date);			
			return json;
		},
		url: function() {
			return '/api/visit/' + this.get('id') + '/';
		}
	});
	
	return VisitModel;
});
