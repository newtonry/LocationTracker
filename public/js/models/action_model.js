define([
	'./location_coordinates_model',
	'./user_model'
], function(
	LocationCoordinates,
	UserModel
) {
	var Action = Backbone.Model.extend({
		parse: function(json) {
			// TODO this is dumb. Should work this out with activerecord
			var start = json.start || json.start_with_venues_and_types;
			var finish = json.finish || json.finish_with_venues_and_types;
	
			json.start = new LocationCoordinates(start, {parse: true});
			json.finish = new LocationCoordinates(finish, {parse: true});
			json.midpoint = new LocationCoordinates(json.midpoint, {parse: true});
			json.user = new UserModel(json.user);
			json.midpoint.set('marker_text', json.user.get('username') + 'on Trip ' + json.id);

			// TODO convert action type to object here as well
			return json;
		}
	});
	
	return Action;
});
