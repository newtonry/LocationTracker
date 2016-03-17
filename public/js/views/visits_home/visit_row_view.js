define([], function() {

	var VisitRowView = Backbone.View.extend({
		tagName: 'tr',
		template: _.template($('#visit-row').html()),
		events: {
			'click [data-action="selectPointOnMap"]': 'selectPointOnMap'
		},
		render: function() {
			this.$el.empty().append(this.template(this.model.toJSON()));
			return this;
		},
		selectPointOnMap: function(e) {
			e.preventDefault();
			this.trigger('selectPointOnMap', this.model);
		},
		
	});

	return VisitRowView;
});
