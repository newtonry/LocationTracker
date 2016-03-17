define([
	'../models/visit_model',
], function(
	VisitModel
) {
	var VisitCollection = Backbone.Collection.extend({
		url: '/api/visits/',
		model: VisitModel,
	});
	
	return VisitCollection;
});
