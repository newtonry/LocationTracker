define([
], function(
) {
	var UserModel = Backbone.Model.extend({
		url: function() {
			return '/api/users/' + this.get('id') + '/';
		}
	});
	
	return UserModel;
});
