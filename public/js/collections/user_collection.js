define([
	'../models/user_model',
], function(
	UserModel
) {
	var UserCollection = Backbone.Collection.extend({
		url: '/api/users/',
		model: UserModel,
	});
	
	return UserCollection;
});
