require(['./placeHolder'], function(placeHolder) {

	$(document).ready(function() {
		// Clashes with erb otherwise
		_.templateSettings = {
		    interpolate: /\{\{\=(.+?)\}\}/g,
		    evaluate: /\{\{(.+?)\}\}/g
		};


		placeHolder();


	});
});
