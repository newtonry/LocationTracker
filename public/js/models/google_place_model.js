define([
	'../collections/type_collection',	
], function(
	TypeCollection
) {
	var GooglePlace = Backbone.Model.extend({
		parse: function(json) {
			json.types = new TypeCollection(json.types, {parse: true})
			return json;
		}
	});
	
	return GooglePlace;
});
