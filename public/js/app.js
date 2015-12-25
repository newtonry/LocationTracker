require(['./placeHolder'], function(placeHolder) {
	$(document).ready(function() {
		_.templateSettings = {
		    interpolate: /\{\{\=(.+?)\}\}/g,
		    evaluate: /\{\{(.+?)\}\}/g
		};



		placeHolder();


	});

	// Clashes with erb otherwise




	// debugger

  // myFile.init();
});
