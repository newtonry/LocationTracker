define([], function() {
	var TripListItemView = Backbone.View.extend({
		events: {
			'click [data-action="navigateToIndividualTrip"]': 'navigateToIndividualTrip'
		},
		tagName: 'tr',
		template: _.template($("#trips-home-table-row").html()),
		navigateToIndividualTrip: function() {
			var individualTripPath = 'trips/' + this.model.get('id');
			Backbone.history.navigate(individualTripPath, {trigger:true});
			$('html,body').scrollTop(0);  // Should I really need this?
		},
	
		render: function() {
			this.$el.empty();
			this.$el.append(
				this.template({
					id: this.model.get('id'),
					startString: this.model.get('start').toCoordinateString(),
					finishString: this.model.get('finish').toCoordinateString(),
					totalTime: this.model.get('total_time')
				})
			);
		
			return this;
		}
	});
	
	return TripListItemView;
});
