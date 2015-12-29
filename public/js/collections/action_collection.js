define([
	'../models/action_model',
], function(
	ActionModel
) {
	var ActionCollection = Backbone.Collection.extend({
		model: ActionModel,
		url: '/api/actions/'
	});
	
	return ActionCollection;
});
