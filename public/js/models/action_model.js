define([
	'./location_coordinates_model'
], function(
	LocationCoordinates
) {
	var Action = Backbone.Model.extend({
		parse: function(json) {

			// TODO this is dumb. Should work this out with activerecord
			var start = json.start || json.start_with_venues_and_types;
			var finish = json.finish || json.finish_with_venues_and_types;
	
			json.start = new LocationCoordinates(start, {parse: true});
			json.finish = new LocationCoordinates(finish, {parse: true});
			
			// TODO convert action type to object here as well
			return json;
		}
	});
	
	return Action;
});
