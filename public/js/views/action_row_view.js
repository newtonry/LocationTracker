define([], function() {

	var ActionRowView = Backbone.View.extend({
		tagName: 'tr',
		events: {
			'click [data-action="selectPointOnMap"]': 'selectPointOnMap'
		},
		template: _.template($('#action-row').html()),
		render: function() {
			this.$el.empty().append(this.template(this.model.toJSON()));
			return this;
		},
		
		selectPointOnMap: function(e) {
			e.preventDefault();
			this.trigger('selectPointOnMap', this.model);
			
			
		}
	});

	return ActionRowView;
});
