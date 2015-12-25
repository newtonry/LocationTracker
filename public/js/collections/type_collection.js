define([
	'../models/type_model',
], function(
	Type
) {
	var TypesCollection = Backbone.Collection.extend({
		model: Type,
		getNamesString: function() {
			return this.map(function(type) {
				return type.get('name');
			}).join(', ');
		}
	});
	
	return TypesCollection;
});
