define([
], function(
) {
	var YelpBusinessCollection = Backbone.Collection.extend({
		parse: function(json_data) {
			return json_data;
		}
	});		
	
	return YelpBusinessCollection;
});
