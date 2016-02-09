define([
], function(
) {
	var GooglePlaceCollection = Backbone.Collection.extend({
		parse: function(json_data) {
			return json_data;
		}
	});		
	
	return GooglePlaceCollection;
});
