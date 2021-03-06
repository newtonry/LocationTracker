define([
	'../models/action_model',
], function(
	ActionModel
) {
	var ActionCollection = Backbone.Collection.extend({
		model: ActionModel,
		url: '/api/actions/',
		
		initialize: function() {
			this.filters = {
				user_id: null,
				type_index: null				
			};
		},
		
		// TODO maybe this should just be part of an api call?
		getFilteredActions: function() {
			return new Backbone.Collection(this.models.filter(function(action) {
				if (this.filters.user_id !== null && action.get('user_id') !== this.filters.user_id) {
						return false;
				} else if (this.filters.type_index !== null && action.get('type_index') !== this.filters.type_index) {
						return false;
				}
				return true;
			}, this));
			
		}
		
	});
	
	return ActionCollection;
});
